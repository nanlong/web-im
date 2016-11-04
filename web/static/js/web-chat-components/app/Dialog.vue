<!-- 对话框 -->
<template lang="html">
  <div class="chat-dialog" v-show="is_open">
    <chat-dialog-header :current-user="current_user"></chat-dialog-header>
    <chat-dialog-container :current-user="current_user"></chat-dialog-container>
    <chat-dialog-footer :current-user="current_user"></chat-dialog-footer>
  </div>
</template>

<script>
import ChatDialogHeader from "./dialog/Header.vue"
import ChatDialogContainer from "./dialog/Container.vue"
import ChatDialogFooter from "./dialog/Footer.vue"

export default {
  name: "dialog",
  components: {
    ChatDialogHeader,
    ChatDialogContainer,
    ChatDialogFooter,
  },
  data: () => {
    return {
      current_user: {},
    }
  },
  computed: {
    is_open () {
      return this.$store.state.dialog.is_open
    },
    chat_current_user () {
      return this.$store.state.current_user
    },
    dialog_current_user () {
      return this.$store.state.dialog.current_user
    },
    room_channel () {
      return this.$store.state.channel.room
    },
  },
  watch: {
    dialog_current_user: function(user, old_user) {
      let socket = this.$store.state.socket
      let topic = [this.chat_current_user.id, user.id].sort().join("&")
      let channel = socket.channel(`dialog:${topic}@${this.chat_current_user.domain}`, {})

      this.room_channel.push("load_user", {user: user})

      channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })

      this.$store.commit("set_dialog_channel", channel)
    },
  },
  created: function() {
    var self = this
    this.room_channel.on("load_user", resp => {
      this.current_user = resp.data
    })
  }
}
</script>

<style lang="css" scoped>
  .chat-dialog {
    position:fixed;
    top: 50%;
    left: 50%;
    width: 600px;
    height: 520px;
    border: 1px solid #ccc;
    background: #fff;
    margin-top: -261px !important;
    margin-left: -301px !important;
    background: #fff;
  }
  .chat-dialog-close-position {
    position: absolute;
    top: 10px;
    right: 10px;
  }
</style>
