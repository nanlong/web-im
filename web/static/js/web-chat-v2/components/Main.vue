<template lang="html">
  <div class="zheye-app-main" v-show="!is_mini">
    <MainHeader></MainHeader>
    <MainContainer></MainContainer>
  </div>
</template>

<script>
import MainHeader from "./main/Header.vue"
import MainContainer from "./main/Container.vue"

export default {
  name: "AppMain",
  components: {MainHeader, MainContainer},
  computed: {
    is_mini () {
      return this.$store.state.is_mini
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-main {
    width: 740px;
    height: 480px;
    position: fixed;
    top: 50%;
    left: 50%;
    margin-left: -370px;
    margin-top: -240px;
    box-shadow: 0 10px 50px #999;
    border: 1px solid #ccc;
    border-radius: 5px;
  }
</style>
