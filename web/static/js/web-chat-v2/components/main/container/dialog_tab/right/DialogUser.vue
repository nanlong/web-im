<template lang="html">
  <div v-show="selected">
    <DialogUserHeader></DialogUserHeader>
    <DialogUserBody></DialogUserBody>
    <DialogUserFooter></DialogUserFooter>
  </div>
</template>

<script>
import DialogUserHeader from "./dialog_user/Header.vue"
import DialogUserBody from "./dialog_user/Body.vue"
import DialogUserFooter from "./dialog_user/Footer.vue"
import Tool from "../../../../../tool"

export default {
  name: "DialogUser",
  components: {DialogUserHeader, DialogUserBody, DialogUserFooter},
  computed: {
    selected () {
      return this.$store.state.main.dialog.left.selected
    },
    socket () {
      return this.$store.state.socket
    },
    current_user () {
      return this.$store.state.current_user
    },
    domain () {
      return this.$store.state.domain
    }
  },
  watch: {
    selected: function(new_selected, old_selected) {
      console.log(new_selected, old_selected)
      if (!new_selected) {
        return
      }

      if (old_selected && old_selected.id == new_selected.id) {
        return
      }

      let id = [this.current_user.id, this.selected.id].sort().join("&")
      let topic = `dialog:${id}@${this.domain}`
      let channel = this.socket.channel(topic)

      channel.join()
        .receive("ok", resp => { Tool.console_log(`Joined Dialog successfully for ${topic}`, resp) })
        .receive("error", resp => { Tool.console_log(`Unable to join Dialog for ${topic}`, resp) })

      this.$store.commit("set_channel_dialog", channel)
    }
  }
}
</script>

<style lang="css">
</style>
