import {Socket, Presence} from "phoenix"

let socket_url = document.domain == "localhost" ? "/socket" : "wss://www.zheye.im/socket"

let socket = new Socket(socket_url, {params: {
  domain: document.domain == "localhost" ? "www.zheye.im" : document.domain,
  webchat_config: zheye.config.webchat,
}})

socket.connect()

// let channel = socket.channel("room:lobby", {})
// let presences = {}
//
// channel.join()
//   .receive("ok", resp => { console.log("Joined successfully", resp) })
//   .receive("error", resp => { console.log("Unable to join", resp) })
//
// let onJoin = (id, current, newPres) => {
//   if(!current){
//     console.log("user has entered for the first time", newPres)
//   } else {
//     console.log("user additional presence", newPres)
//   }
// }
//
// let onLeave = (id, current, leftPres) => {
//   if(current.metas.length === 0){
//     console.log("user has left from all devices", leftPres)
//   } else {
//     console.log("user left from a device", leftPres)
//   }
// }
//
// channel.on("presence_state", state => {
//   presences = Presence.syncState(presences, state, onJoin, onLeave)
// })
//
// channel.on("presence_diff", diff => {
//   presences = Presence.syncDiff(presences, diff, onJoin, onLeave)
// })
//
// channel.push("new_status", {status: "leave"})

export default socket
