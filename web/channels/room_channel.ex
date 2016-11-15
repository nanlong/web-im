defmodule Zheye.RoomChannel do
  use Zheye.Web, :channel

  alias Zheye.{Presence, WebChatUser, WebChatFriend, WebChatUserView}

  def join("room:lobby", _, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_in("current_user", _, socket) do
    push socket, "current_user", Phoenix.View.render(WebChatUserView, "entry.json", entry: socket.assigns.user)

    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("new_status", %{"status" => status}, socket) do
    # status = online or awa
    {:ok, _} = Presence.update(socket, socket.assigns.user_id, %{
      status: status
    })

    {:noreply, socket}
  end

  def handle_in("load_user", %{"user" => user_params}, socket) do
    user_params = user_params
    |> Map.put_new("origin_domain", socket.assigns.domain)
    |> Map.put_new("origin_id", Map.get(user_params, "id"))

    {:ok, user}  = WebChatUser.get(user_params)

    user_data = Phoenix.View.render(WebChatUserView, "entry", entry: user, current_user: socket.assigns.user)

    push socket, "load_user", %{data: user_data}
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))

    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      status: "online"
    })

    {:noreply, socket}
  end
end
