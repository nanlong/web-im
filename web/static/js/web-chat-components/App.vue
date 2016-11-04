<template>
  <div id="zheye-web-chat-app">
    <chat-main></chat-main>
    <chat-main-mini></chat-main-mini>
    <chat-dialog></chat-dialog>
    <chat-message></chat-message>
    <chat-setup></chat-setup>
  </div>
</template>

<script>
import ChatMain from "./app/Main.vue"
import ChatMainMini from "./app/Mini.vue"
import ChatDialog from "./app/Dialog.vue"
import ChatMessage from "./app/Message.vue"
import ChatSetup from "./app/Setup.vue"
import ChatSearch from "./app/Search.vue"

export default {
  name: "app",
  components: {
    ChatMain,
    ChatMainMini,
    ChatDialog,
    ChatMessage,
    ChatSetup,
    ChatSearch,
  },
  created: function() {
    let socket = this.$store.state.socket
    let room_channel = this.$store.state.channel.room

    room_channel.push("current_user", {})

    room_channel.on("current_user", resp => {
      this.$store.commit("set_current_user", resp)

      let self_topic = `self:${resp.id}@${resp.domain}`
      let self_channel = socket.channel(self_topic, {})

      self_channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })

      self_channel.on("notification:dialog", resp => {
        let dialog = this.$store.state.dialog
        if (!dialog.is_open) {
          this.$store.commit("open_message", resp)
        }
        else {
          this.$store.commit("push_dialog_user_list", resp.user)
        }
      })

      self_channel.on("notification:firend", resp => {
        if (confirm(`收到用户 ${resp.user.name} 的好友申请，是否加对方为好友？`)) {
          self_channel.push("add_firend:confirmed", resp)
        }
      })

      self_channel.on("load_firends", resp => {
        this.$store.commit("set_firends", resp.data)
      })

      this.$store.commit("set_self_channel", self_channel)
    })
  }
}
</script>

<style>
  #zheye-web-chat-app {
    position: fixed;
    width: 0;
    height: 0;
    right: 0;
    bottom: 0;
    font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
    font-size: 14px;
    line-height: 1.5;
    color: #333;
  }
  #zheye-web-chat-app div, ul, li, h1, h2, h3, h4, h5, h6 {
    margin: 0;
    padding: 0;
  }
  #zheye-web-chat-app ul, li {
    list-style: none;
  }
  #zheye-web-chat-app .is-clearfix:after {
    clear: both;
    content: " ";
    display: table;
  }
  #zheye-web-chat-app .is-pulled-left {
    float: left;
  }
  #zheye-web-chat-app .is-pulled-right {
    float: right;
  }
  #zheye-web-chat-app .has-text-centered {
    text-align: center;
  }
  #zheye-web-chat-app .gray {
    -webkit-filter: grayscale(100%);
    -moz-filter: grayscale(100%);
    -ms-filter: grayscale(100%);
    -o-filter: grayscale(100%);
    filter: grayscale(100%);
    filter: gray;
  }
</style>
