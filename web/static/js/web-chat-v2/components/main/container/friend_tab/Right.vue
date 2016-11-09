<template lang="html">
  <div class="zheye-app-main-right">
    <FriendShow></FriendShow>
  </div>
</template>

<script>
import FriendShow from "./right/FriendShow.vue"

export default {
  name: "MainFriendTabRight",
  components: {FriendShow},
}
</script>

<style lang="css" scoped>
  .zheye-app-main-right {
    position: absolute;
    top: 0;
    left: 200px;
    right: 0;
    bottom: 0;
    background: #fff;
    border-radius: 0 0 5px 0;
  }
</style>
