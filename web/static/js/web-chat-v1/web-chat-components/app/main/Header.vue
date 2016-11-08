<!-- 头部 -->
<template lang="html">
  <div class="chat-main-header">
    <chat-current-user></chat-current-user>
    <chat-main-close class="chat-main-close-position"></chat-main-close>
  </div>
</template>

<script>
import ChatCurrentUser from "./CurrentUser.vue"
import ChatMainClose from "./Close.vue"

export default {
  name: "main-header",
  components: {
    ChatCurrentUser,
    ChatMainClose
  }
}
</script>

<style lang="css" scoped>
  .chat-main-header {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 65px;
  }
  .chat-main-close-position {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
  }
</style>
