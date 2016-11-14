<template lang="html">
  <div class="zheye-app-dialog-user-header" v-if="selected">
    <span class="zheye-app-dialog-user-header-name">
      {{ selected.name }}
    </span>
  </div>
</template>

<script>
export default {
  name: "DialogUserHeader",
  computed: {
    selected () {
      return this.$store.state.main.dialog.left.current
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-dialog-user-header {
    height: 45px;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    background: #fff;
  }
  .zheye-app-dialog-user-header-name {
    line-height: 45px;
    margin-left: 10px;
  }
</style>
