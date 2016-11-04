defmodule Zheye.UserSocket do
  use Phoenix.Socket

  alias Zheye.WebChatUser
  ## Channels
  # channel "room:*", Zheye.RoomChannel
  channel "room:lobby", Zheye.RoomChannel
  channel "self:*", Zheye.SelfChannel
  channel "dialog:*", Zheye.DialogChannel


  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(%{"domain" => domain, "webchat_config" => user_data}, socket) do
    domain = domain |> String.split(".") |> Enum.slice(-2, 2) |> Enum.join(".")
    params = user_data |> Map.put_new("origin_domain", domain)

    {:ok, user} = params |> WebChatUser.get

    socket = socket
    |> assign(:domain, domain)
    |> assign(:user_id, user.id)
    |> assign(:user, user)

    {:ok, socket}
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Zheye.Endpoint.broadcast("users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
