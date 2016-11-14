<template lang="html">
  <div id="zheye-app">
    <AppMain></AppMain>
    <AppMini></AppMini>
  </div>
</template>

<script>
import AppMain from "./Main.vue"
import AppMini from "./Mini.vue"
import Tool from "../tool"

export default {
  name: "App",
  components: {AppMain, AppMini},
  computed: {
    socket () {
      return this.$store.state.socket
    },
    domain () {
      return this.$store.state.domain
    },
    current_user () {
      return this.$store.state.current_user
    }
  },
  created: function() {
    let room_channel = this.socket.channel("room:lobby")
    let self_channel = this.socket.channel(`self:${this.current_user.id}@${this.domain}`)

    room_channel.join()
      .receive("ok", resp => { Tool.console_log("Joined Room successfully", resp) })
      .receive("error", resp => { Tool.console_log("Unable to join Room", resp) })

    self_channel.join()
      .receive("ok", resp => { Tool.console_log("Joined Self successfully", resp) })
      .receive("error", resp => { Tool.console_log("Unable to join Self", resp) })

    self_channel.on("load_friends", resp => {
      Tool.console_log("加载好友列表")
      this.$store.commit("set_main_friend_left_data", resp.data)
    })

    self_channel.on("load_notifications:dialog", resp => {
      this.$store.commit("set_notification_dialog", resp.data)
    })

    self_channel.on("notification:dialog", resp => {
      Tool.console_log("有新消息")
      this.$store.commit("push_notification_dialog", resp)
    })

    self_channel.on("notification:firend", resp => {
      Tool.console_log("有新好友请求")
    })

    self_channel.on("notification:system", resp => {
      Tool.console_log("有系统消息")
    })

    this.$store.commit("set_channel_room", room_channel)
    this.$store.commit("set_channel_self", self_channel)
  }
}
</script>

<style lang="css">
  #zheye-app {
    position: fixed;
    height: 0;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 1000000;
  }
  #zheye-app ul, #zheye-app li {
    margin: 0;
    padding: 0;
  }
  #zheye-app ul, #zheye-app li {
    list-style: none;
  }
</style>
