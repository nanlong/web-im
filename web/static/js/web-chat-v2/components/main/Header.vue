<template lang="html">
  <div class="zheye-app-main-header">
    <div class="zheye-app-main-current-user">
      <article class="zheye-app-main-current-user-avatar">
        <img :src="current_user.avatar" :alt="current_user.name" :title="current_user.name" />
      </article>
    </div>

    <div class="zheye-app-main-controller">
      <span class="zheye-app-main-close" @click="close_main">x</span>
      <span class="zheye-app-main-search">
        <input type="text" name="q" value="">
      </span>
    </div>
  </div>
</template>

<script>
export default {
  name: "MainHeader",
  computed: {
    current_user () {
      return this.$store.state.current_user
    }
  },
  methods: {
    close_main: function() {
      this.$store.commit("close_main")
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-main-header {
    height: 55px;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    background-color: rgba(240, 240, 240, 0.8);
    border-radius: 5px 5px 0 0;
  }
  .zheye-app-main-current-user-avatar img {
    width: 25px;
    height: 25px;
    border-radius: 100%;
  }
  .zheye-app-main-current-user {
    float: right;
    padding: 15px;
  }
  .zheye-app-main-controller {
    padding: 15px;
  }
  .zheye-app-main-close {
    display: inline-block;
    cursor: pointer;
    width: 12px;
    height: 12px;
    border-radius: 100%;
    overflow: hidden;
    background: rgb(255, 100, 90);
    color: #fff;
    font-size: 12px;
    text-align: center;
    line-height: 12px;
    margin-right: 10px;
    position: relative;
    top: 3px;
  }
  .zheye-app-main-search input {
    width: 125px;
    height: 25px;
    line-height: 25px;
    border-radius: 25px;
    border: none;
    outline: none;
    padding: 0 10px;
  }
</style>
