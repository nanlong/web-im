<template lang="html">
  <div class="zheye-app-mini" v-show="is_mini" @click="open_main">
    <span>者也 IM</span>
  </div>
</template>

<script>
export default {
  name: "Mini",
  computed: {
    is_mini () {
      return this.$store.state.is_mini
    }
  },
  methods: {
    open_main: function() {
      this.$store.commit("open_main")
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-mini {
    position: absolute;
    left: 10px;
    bottom: 10px;
    border: 1px solid #ccc;
    padding: 5px 20px;
    border-radius: 30px;
    cursor: pointer;
    box-shadow: 0 3px 3px #999;
  }
</style>
