<template lang="html">
  <div id="zheye-app">
    <AppMain></AppMain>
  </div>
</template>

<script>
import AppMain from "./Main.vue"
import Tool from "../tool"

export default {
  name: "App",
  components: {AppMain,},
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

    self_channel.on("load_firends", resp => {
      Tool.console_log("加载好友列表")
      this.$store.commit("set_main_firends", resp.data)
    })

    self_channel.on("notification:dialog", resp => {
      Tool.console_log("有新消息")
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
</style>
