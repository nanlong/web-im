<template lang="html">
  <div class="">
    <Friend v-for="user in friends" :key="user.id" :user="user"></Friend>
  </div>
</template>

<script>
import Friend from "./Friend.vue"

export default {
  name: "FriendList",
  components: {Friend,},
  computed: {
    friends () {
      return this.$store.state.main.friends
    }
  }
}
</script>

<style lang="css">
</style>
