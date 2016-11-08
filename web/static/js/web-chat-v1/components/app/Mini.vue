<!-- 折叠状态 -->
<template lang="html">
  <div class="chat-main-mini has-text-centered" v-show="is_mini" @click="open">
    者也 IM
  </div>
</template>

<script>
export default {
  name: "mini",
  computed: {
    is_mini () {
      return this.$store.state.main.is_mini
    }
  },
  methods: {
    open: function(e) {
      this.$store.commit("toggle_mini")
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-main-mini {
    width: 260px;
    position: absolute;
    right: 5px;
    bottom: 5px;
    border: 1px solid #ccc;
    height: 35px;
    line-height: 35px;
    cursor: pointer;
    background: #F6F6F6;
  }
</style>
