defmodule Zheye.DialogChannel do
  use Zheye.Web, :channel

  alias Zheye.{WebChatUser, WebChatDialog}

  def join("dialog:" <> _user_info, _, socket) do
    {:ok, socket}
  end

  def handle_in("shout", payload, socket) do
    {:ok, dialog} = %WebChatDialog{
      domain: socket.assigns.domain,
    }
    |> WebChatDialog.changeset(payload)
    |> Repo.insert

    user = WebChatUser |> Repo.get_by(origin_domain: socket.assigns.domain, origin_id: dialog.from_id)

    dialog_data = %{
      id: dialog.id,
      from_id: dialog.from_id,
      to_id: dialog.to_id,
      content: dialog.content,
      inserted_at: dialog.inserted_at,
      user: %{
        id: user.origin_id,
        name: user.name,
        avatar: user.avatar,
        bio: user.bio,
      }
    }

    broadcast socket, "shout", dialog_data

    self_topic = "self:" <> dialog.to_id <> "@" <> socket.assigns.domain
    socket.endpoint.broadcast self_topic, "notification:dialog", dialog_data
    
    {:noreply, socket}
  end

  def handle_in("get_dialog_history", _, socket) do
    [_, user_info] = socket.topic |> String.split(":")
    [user_info, _] = user_info |> String.split("@")
    [user_1, user_2] = user_info |> String.split("&")

    dialog_list = WebChatDialog
      |> where([d], d.domain == ^socket.assigns.domain)
      |> where([d], (d.from_id == ^user_1 and d.to_id == ^user_2) or (d.from_id == ^user_2 and d.to_id == ^user_1))
      |> order_by([desc: :inserted_at])
      |> limit(20)
      |> Repo.all
      |> Enum.reverse

    dialog_list_data = Enum.map(dialog_list, fn dialog ->
      user = WebChatUser |> Repo.get_by(origin_domain: socket.assigns.domain, origin_id: dialog.from_id)

      %{
        id: dialog.id,
        from_id: dialog.from_id,
        to_id: dialog.to_id,
        content: dialog.content,
        inserted_at: dialog.inserted_at,
        user: %{
          id: user.origin_id,
          name: user.name,
          avatar: user.avatar,
          bio: user.bio,
        }
      }
    end)

    push socket, "get_dialog_history", %{data: dialog_list_data}

    {:noreply, socket}
  end
end
