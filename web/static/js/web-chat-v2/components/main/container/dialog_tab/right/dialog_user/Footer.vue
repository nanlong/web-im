<template lang="html">
  <div class="zheye-app-dialog-user-footer">
    <div class="zheye-app-dialog-user-footer-tools">
      <span>表情</span>
      <span>图片</span>
      <span>文件</span>
      <span>聊天记录</span>
    </div>
    <div class="zheye-app-dialog-user-footer-textarea">
      <textarea name="content" v-model="content" @keyup.13="send"></textarea>
    </div>

  </div>
</template>

<script>
export default {
  name: "DialogUserFooter",
  data: () => {
    return {
      content: ""
    }
  },
  computed: {
    channel () {
      return this.$store.state.channel.dialog
    },
    current_user () {
      return this.$store.state.current_user
    },
    selected () {
      return this.$store.state.main.dialog.left.selected
    }
  },
  methods: {
    send: function() {
      this.channel.push("shout", {
        from_id: this.current_user.id,
        to_id: this.selected.id,
        content: this.content,
      })
      this.clear_content()
    },
    clear_content: function() {
      this.content = ""
    }
  }
}
</script>

<style lang="css">
  .zheye-app-dialog-user-footer {
    height: 121px;
    border-top: 1px solid #eee;
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
  }
  .zheye-app-dialog-user-footer-tools {
    height: 40px;
    padding-left: 10px;
    line-height: 40px;
    color: #999;
  }
  .zheye-app-dialog-user-footer-tools span {
    cursor: pointer;
  }
  .zheye-app-dialog-user-footer-textarea textarea {
    border: 0;
    outline: 0;
    width: 100%;
    height: 75px;
    resize: none;
    padding: 0 10px;
  }
</style>
