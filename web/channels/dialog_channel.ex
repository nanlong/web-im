defmodule Zheye.DialogChannel do
  use Zheye.Web, :channel

  alias Zheye.{Presence, WebChatUser, WebChatDialog, WebChatDialogNotification,
    WebChatDialogView}

  def join("dialog:" <> _user_info, _, socket) do
    {:ok, socket}
  end

  def handle_in("shout", payload, socket) do
    {:ok, dialog} = %WebChatDialog{
      domain: socket.assigns.domain,
    }
    |> WebChatDialog.changeset(payload)
    |> Repo.insert

    dialog_data = Phoenix.View.render(WebChatDialogView, "entry.json", entry: dialog)

    broadcast socket, "shout", dialog_data

    self_topic = "self:" <> dialog.to_id <> "@" <> socket.assigns.domain

    to_user = WebChatUser |> Repo.get_by(origin_domain: socket.assigns.domain, origin_id: dialog.to_id)
    case Presence.list(self_topic) |> Map.fetch(to_user.id) do
      {:ok, _} ->
        socket.endpoint.broadcast! self_topic, "notification:dialog", dialog_data

      :error ->
        %WebChatDialogNotification{
          domain: socket.assigns.domain,
          from_user_id: dialog.from_id,
          to_user_id: dialog.to_id,
        }
        |> Repo.insert
    end

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

    push socket, "get_dialog_history", Phoenix.View.render(WebChatDialogView, "entries.json", entries: dialog_list)

    {:noreply, socket}
  end
end
