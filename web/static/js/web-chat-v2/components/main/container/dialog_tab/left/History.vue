<template lang="html">
  <div class="zheye-app-main-history"
    :class="{selected: selected && selected.id == history.id}"
    @click="selected_item">
    <article class="zheye-app-main-history-avatar">
      <img :src="history.avatar" :alt="history.name" :title="history.name" />
    </article>
    <div class="zheye-app-main-history-info">
      <div class="zheye-app-main-history-name">
        {{ history.name }}
      </div>
      <div class="zheye-app-main-history-bio">
        {{ history.bio }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "HistoryItem",
  props: ["history"],
  computed: {
    selected () {
      return this.$store.state.main.dialog.left.selected
    },
  },
  methods: {
    selected_item: function() {
      this.$store.commit("set_main_dialog_left_selected", this.history)
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-main-history {
    padding: 15px;
    height: 70px;
  }
  .zheye-app-main-history.selected {
    background: rgb(239, 241, 245);
  }
  .zheye-app-main-history-avatar {
    float: left;
  }
  .zheye-app-main-history-avatar img {
    width: 40px;
    height: 40px;
    border-radius: 100%;
  }
  .zheye-app-main-history-info {
    margin-left: 50px;
  }
  .zheye-app-main-history-name {
    padding-top: 3px;
  }
  .zheye-app-main-history-bio {
    font-size: 12px;
    color: #999;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
</style>
