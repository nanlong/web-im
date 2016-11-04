<template lang="html">
  <div class="chat-dialog-footer">
    <div class="chat-dialog-footer-tools is-clearfix">
      <div class="is-pulled-left">
        表情 图片 文件
      </div>
      <div class="is-pulled-right">
        聊天记录
      </div>
    </div>
    <div class="chat-dialog-footer-editor">
      <textarea id="chat-dialog-footer-editor" name="content" v-model="content"></textarea>
    </div>
    <div class="chat-dialog-footer-buttons">
      <button type="button" name="button" @click="send">
        发送
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "dialog-footer",
  props: ["currentUser"],
  data: () => {
    return {
      content: "",
    }
  },
  computed: {
    toggle_current_user () {
      return this.$store.state.dialog.current_user
    },
  },
  watch: {
    toggle_current_user: function(user, old_user) {
      this.clear()
    }
  },
  methods: {
    clear: function() {
      this.content = ""
      document.querySelector('#chat-dialog-footer-editor').focus()
    },
    send: function() {
      let channel = this.$store.state.channel.dialog

      channel.push("shout", {
        from_id: this.$store.state.current_user.id,
        to_id: this.currentUser.id,
        content: this.content,
      })

      this.clear()
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-dialog-footer {
    height: 160px;
    position: absolute;
    right: 0;
    bottom: 0;
    left: 0;
    border-top: 1px solid #eee;
  }
  .chat-dialog-footer-tools {
    height: 40px;
    line-height: 40px;
    padding: 0 10px !important;
  }
  .chat-dialog-footer-editor textarea {
    border: 0;
    width: 100%;
    height: 80px;
    resize: none;
    padding: 5px 10px;
    outline: 0;
  }
  .chat-dialog-footer-buttons {
    height: 40px;
    text-align: right;
    padding: 0 10px !important;
  }
</style>
