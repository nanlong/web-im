import {Socket, Presence} from "phoenix"
import Tool from "./tool"

let socket_url = Tool.is_dev() ? "/socket" : "wss://www.zheye.im/socket"

let socket = new Socket(socket_url, {params: {
  domain: Tool.get_domain(),
  webchat_config: zheye.config.webchat,
}})

socket.connect()

export default socket
