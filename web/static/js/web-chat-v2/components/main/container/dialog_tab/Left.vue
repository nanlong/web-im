<template lang="html">
  <div class="zheye-app-main-left">
    <HistoryList></HistoryList>
  </div>
</template>

<script>
import HistoryList from "./left/HistoryList.vue"

export default {
  name: "MainDialogTabLeft",
  components: {HistoryList},
}
</script>

<style lang="css" scoped>
  .zheye-app-main-left {
    width: 200px;
    border-right: 1px solid #eee;
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    background: rgb(255, 255, 255);
    border-radius: 0 0 0 5px;
    overflow-y: auto;
  }
</style>
