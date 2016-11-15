defmodule Zheye.SelfChannel do
  use Zheye.Web, :channel

  alias Zheye.{Presence, WebChatUser, WebChatFriendRequest, WebChatFriend,
    WebChatDialogNotification, WebChatUserView, WebChatDialogNotificationView}

  import Zheye.Ecto.Helpers

  def join("self:" <> _user_info, _payload, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    friends = WebChatFriend
    |> where([f], f.domain == ^socket.assigns.domain)
    |> where([f], f.left_user_id == ^socket.assigns.user.origin_id or f.right_user_id == ^socket.assigns.user.origin_id)
    |> Repo.all

    friends_id = (for item <- friends, do: [item.left_user_id, item.right_user_id])
    |> Enum.concat
    |> Enum.uniq
    |> Enum.filter(fn (x) -> x != socket.assigns.user.origin_id end)

    friends_user = WebChatUser
    |> where([u], u.origin_domain == ^socket.assigns.domain)
    |> where([u], u.origin_id in ^friends_id)
    |> Repo.all

    friends_user_data = Phoenix.View.render(WebChatUserView, "entries.json", entries: friends_user)

    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      status: "online"
    })

    push socket, "load_friends", friends_user_data

    notifications_dialog = WebChatDialogNotification
    |> where([n], n.domain == ^socket.assigns.domain)
    |> where([n], n.to_user_id == ^socket.assigns.user.origin_id)
    |> Repo.all

    push socket, "load_notifications:dialog", Phoenix.View.render(WebChatDialogNotificationView, "entries.json", entries: notifications_dialog)

    {:noreply, socket}
  end

  def handle_in("read_notifications:dialog", _, socket) do
    WebChatDialogNotification
    |> where([n], n.domain == ^socket.assigns.domain)
    |> where([n], n.to_user_id == ^socket.assigns.user.origin_id)
    |> Repo.delete_all

    {:noreply, socket}
  end

  def handle_in("is_friend", %{"id" => user_id}, socket) do
    user = WebChatUser |> Repo.get_by(origin_domain: socket.assigns.domain, origin_id: user_id)

    data = %{
      id: user_id,
      is_friend: WebChatFriend.is_friend?(socket.assigns.domain, socket.assigns.user, user)
    }

    push socket, "is_friend", data

    {:noreply, socket}
  end

  def handle_in("add_friend", %{"id" => user_id}, socket) do
    user = WebChatUser |> Repo.get_by(origin_domain: socket.assigns.domain, origin_id: user_id)

    params = %{
      domain: socket.assigns.domain,
      from_user_id: socket.assigns.user.origin_id,
      to_user_id: user_id
    }

    {:ok, request} = WebChatFriendRequest.create(params)

    topic = "self:" <> user_id <> "@" <> socket.assigns.domain

    data = %{
      id: request.id,
      user: Phoenix.View.render(WebChatUserView, "entry.json", entry: socket.assigns.user)
    }

    socket.endpoint.broadcast topic, "notification:friend", data

    {:noreply, socket}
  end

  def handle_in("add_friend:confirmed", payload, socket) do
    request = WebChatFriendRequest
    |> Repo.get(Map.get(payload, "id"))
    |> update_field(:is_confirmed, true)

    [left_user_id, right_user_id] = [request.from_user_id, request.to_user_id] |> Enum.sort

    params = %{
      domain: socket.assigns.domain,
      left_user_id: left_user_id,
      right_user_id: right_user_id
    }

    %WebChatFriend{}
    |> WebChatFriend.changeset(params)
    |> Repo.insert

    {:noreply, socket}
  end
end
