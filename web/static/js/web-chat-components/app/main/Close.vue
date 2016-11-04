<!-- 关闭 -->
<template lang="html">
  <span class="chat-main-close" @click="close">x</span>
</template>

<script>
export default {
  name: "close",
  methods: {
    close: function(e) {
      this.$store.commit("toggle_mini")
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-main-close {

  }
</style>
