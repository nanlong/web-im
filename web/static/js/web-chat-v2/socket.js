import {Socket, Presence} from "phoenix"

let socket_url = document.domain == "localhost" ? "/socket" : "wss://www.zheye.im/socket"

let socket = new Socket(socket_url, {params: {
  domain: document.domain == "localhost" ? "www.zheye.im" : document.domain,
  webchat_config: zheye.config.webchat,
}})

socket.connect()

export default socket
