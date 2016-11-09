<template lang="html">
  <div class="">
    <MainFriendTabLeft></MainFriendTabLeft>
    <MainFriendTabRight></MainFriendTabRight>
  </div>
</template>

<script>
import MainFriendTabLeft from "./friend_tab/Left.vue"
import MainFriendTabRight from "./friend_tab/Right.vue"

export default {
  name: "MainFriendTab",
  components: {MainFriendTabLeft, MainFriendTabRight}
}
</script>

<style lang="css">
</style>
