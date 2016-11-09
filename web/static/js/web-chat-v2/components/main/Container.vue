<template lang="html">
  <div class="zheye-app-main-container">
    <MainDialogTab v-show="current_tab == 'dialog'"></MainDialogTab>
    <MainFriendTab v-show="current_tab == 'friend'"></MainFriendTab>
  </div>
</template>

<script>
import MainDialogTab from "./container/DialogTab.vue"
import MainFriendTab from "./container/FriendTab.vue"

export default {
  name: "MainContainer",
  components: {MainDialogTab, MainFriendTab},
  computed: {
    current_tab () {
      return this.$store.state.main.current_tab
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-main-container {
    position: absolute;
    top: 55px;
    left: 0;
    right: 0;
    bottom: 0;
  }
</style>
