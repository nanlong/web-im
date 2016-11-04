<template lang="html">
  <div class="chat-main-container">
    <ul>
      <li class="chat-main-firend-item" v-for="user in firends">
        <firend :firend="user"></firend>
      </li>
    </ul>
  </div>
</template>

<script>
import Firend from "./Firend.vue"

export default {
  name: "container",
  components: {
    Firend
  },
  computed: {
    firends () {
      return this.$store.state.main.firends
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-main-container {
    background: #fff;
    position: absolute;
    top: 100px;
    left: 0;
    right: 0;
    bottom: 35px;
    overflow-y: auto;
  }
</style>
