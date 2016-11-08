<!-- 主体 -->
<template>
  <div id="main" v-show="!is_mini">
    <chat-main-header></chat-main-header>
    <chat-main-tabs></chat-main-tabs>
    <chat-main-container></chat-main-container>
    <chat-main-footer></chat-main-footer>
  </div>
</template>

<script>
import ChatMainHeader from "./main/Header.vue"
import ChatMainTabs from "./main/Tabs.vue"
import ChatMainContainer from "./main/Container.vue"
import ChatMainFooter from "./main/Footer.vue"

export default {
  name: "main",
  computed: {
    is_mini () {
      return this.$store.state.main.is_mini
    }
  },
  components: {
    ChatMainHeader,
    ChatMainTabs,
    ChatMainContainer,
    ChatMainFooter,
  }
}
</script>

<style lang="css" scoped>
  #main {
    width:260px;
    height: 500px;
    border: 1px solid #ccc;
    background: #fff;
    position: absolute;
    bottom: 5px;
    right: 5px;
    background: #F6F6F6;
  }
</style>
