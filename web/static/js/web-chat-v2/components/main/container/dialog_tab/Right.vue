<template lang="html">
  <div class="zheye-app-main-right">
    <DialogUser></DialogUser>
    <NotificationFriend></NotificationFriend>
  </div>
</template>

<script>
import DialogUser from "./right/DialogUser.vue"
import NotificationFriend from "./right/NotificationFriend.vue"

export default {
  name: "MainDialogTabRight",
  components: {DialogUser, NotificationFriend},
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
