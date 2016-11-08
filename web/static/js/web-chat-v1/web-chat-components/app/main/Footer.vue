<template lang="html">
  <div class="chat-main-footer has-text-centered">
    Powered by
    <a href="http://www.phoenixframework.org/" target="_blank">
      PhoenixFramework
    </a>
  </div>
</template>

<script>
export default {
  name: "footer"
}
</script>

<style lang="css" scoped>
  .chat-main-footer {
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    height: 35px;
    line-height: 35px;
    padding: 0 10px !important;
  }
</style>
