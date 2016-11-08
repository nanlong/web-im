<!-- 关闭 -->
<template lang="html">
  <span class="chat-dialog-close" @click="close">x</span>
</template>

<script>
export default {
  name: "dialog_close",
  methods: {
    close: function() {
      this.$store.commit("close_dialog")
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-dialog-close {
    cursor: pointer;
  }
</style>
