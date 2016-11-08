<template lang="html">
  <div class="zheye-app-main-left">
    <MainFriend v-for="user in friends" :key="user.id" :user="user"></MainFriend>
  </div>
</template>

<script>
import MainFriend from "./Friend.vue"

export default {
  name: "MainLeft",
  components: {MainFriend,},
  computed: {
    friends () {
      return this.$store.state.main.friends
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-main-left {
    width: 200px;
    border-right: 1px solid rgb(220, 220, 220);
    position: absolute;
    top: 55px;
    left: 0;
    bottom: 0;
    background: rgb(255, 255, 255);
    border-radius: 0 0 0 5px;
  }
</style>
