defmodule Zheye.SelfChannel do
  use Zheye.Web, :channel

  alias Zheye.{WebChatUser, WebChatFriendRequest, WebChatFriend}

  import Zheye.Ecto.Helpers

  def join("self:" <> _user_info, _payload, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    firends = WebChatFriend
    |> where([f], f.domain == ^socket.assigns.domain)
    |> where([f], f.left_user_id == ^socket.assigns.user.origin_id or f.right_user_id == ^socket.assigns.user.origin_id)
    |> Repo.all

    firends_id = (for item <- firends, do: [item.left_user_id, item.right_user_id])
    |> Enum.concat
    |> Enum.uniq
    |> Enum.filter(fn (x) -> x != socket.assigns.user.origin_id end)

    firends_user = WebChatUser
    |> where([u], u.origin_domain == ^socket.assigns.domain)
    |> where([u], u.origin_id in ^firends_id)
    |> Repo.all

    firends_user_data = Enum.map(firends_user, fn user ->
      %{
        id: user.origin_id,
        name: user.name,
        avatar: user.avatar,
        bio: user.bio
      }
    end)

    push socket, "load_friends", %{data: firends_user_data}

    {:noreply, socket}
  end

  def handle_in("add_friend", payload, socket) do
    params = %{
      domain: socket.assigns.domain,
      from_user_id: socket.assigns.user.origin_id,
      to_user_id: Map.get(payload, "id")
    }

    {:ok, request} = WebChatFriendRequest.create(params)

    user = socket.assigns.user
    topic = "self:" <> Map.get(payload, "id") <> "@" <> socket.assigns.domain

    data = Map.merge(%{
        id: request.id,
        user: %{
          id: user.origin_id,
          name: user.name,
          avatar: user.avatar,
          bio: user.bio,
        }
      }, params)

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
