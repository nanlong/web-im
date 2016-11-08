<template lang="html">
  <div id="zheye-app">
    <AppMain></AppMain>
  </div>
</template>

<script>
import AppMain from "./Main.vue"

export default {
  name: "App",
  components: {AppMain,},
  created: function() {

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
