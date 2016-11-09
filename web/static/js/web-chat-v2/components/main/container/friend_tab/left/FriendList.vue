<template lang="html">
  <div class="">
    <Friend v-for="user in data" :key="user.id" :user="user"></Friend>
  </div>
</template>

<script>
import Friend from "./Friend.vue"

export default {
  name: "FriendList",
  components: {Friend,},
  computed: {
    data () {
      return this.$store.state.main.friend.left.data
    }
  }
}
</script>

<style lang="css">
</style>
