<template lang="html">
  <div class="zheye-app-main-history"
    :class="{selected: selected && selected.id == history.id}"
    @mouseenter="show_remove_btn = true"
    @mouseleave="show_remove_btn = false">

    <div class="zheye-app-main-history-content" @click="selected_item">
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
      <div class="zheye-app-main-history-right" v-if="noread > 0">
        <span class="zheye-badge">{{ noread }}</span>
      </div>
    </div>

    <span class="zheye-app-main-history-remove"
      v-show="show_remove_btn"
      @click="remove">
      x
    </span>
  </div>
</template>

<script>
export default {
  name: "HistoryItem",
  props: ["history"],
  data: () => {
    return {
      show_remove_btn: false,
    }
  },
  computed: {
    selected () {
      return this.$store.state.main.dialog.left.current
    },
    noread () {
      if (this.selected && this.history.id == this.selected.id) {
        this.$store.commit("reset_notification_dialog_statistics", this.history.id)
      }
      return this.$store.state.main.notification.dialog.noread(this.history.id)
    },
  },

  methods: {
    selected_item: function() {
      this.$store.commit("set_main_dialog_left_selected", this.history)
    },
    remove: function() {
      this.$store.commit("remove_main_dialog_left_data", this.history)
    },
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-main-history {
    position: relative;
  }
  .zheye-app-main-history-content {
    padding: 15px 20px;
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
  .zheye-app-main-history-remove {
    position: absolute;
    left: 7px;
    top: 25px;
    cursor: pointer;
    color: #999;
  }
  .zheye-badge {
    position: absolute;
    background: #f00;
    border-radius: 100%;
    min-width: 16px;
    text-align: center;
    color: #fff;
    top: 25px;
    right: 10px;
    font-size: 12px;
  }
</style>
