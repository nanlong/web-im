<template lang="html">
  <div class="zheye-app-mini" v-show="is_mini" @click="open_main">
    <span>者也 IM</span>
    <span class="zheye-badge" v-show="notification_total > 0">
      {{ notification_total }}
    </span>
  </div>
</template>

<script>
export default {
  name: "Mini",
  computed: {
    is_mini () {
      return this.$store.state.is_mini
    },
    notification_total () {
      return this.$store.state.main.notification.dialog.total
    }
  },
  methods: {
    open_main: function() {
      if (this.notification_total > 0) {
        this.$store.commit("open_main", "dialog")
      }
      else {
        this.$store.commit("open_main")
      }
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
    background: #fff;
  }
  .zheye-badge {
    position: absolute;
    background: #f00;
    border-radius: 100%;
    min-width: 16px;
    text-align: center;
    color: #fff;
    top: -5px;
    right: -5px;
    font-size: 12px;
  }
</style>
