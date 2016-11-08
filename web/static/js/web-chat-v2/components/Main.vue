<template lang="html">
  <div class="zheye-app-main" v-show="is_show">
    <MainHeader></MainHeader>
    <MainLeft></MainLeft>
    <MainRight></MainRight>
  </div>
</template>

<script>
import MainHeader from "./main/Header.vue"
import MainLeft from "./main/Left.vue"
import MainRight from "./main/Right.vue"

export default {
  name: "AppMain",
  components: {MainHeader, MainLeft, MainRight},
  computed: {
    is_show () {
      return this.$store.state.main.is_show
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
