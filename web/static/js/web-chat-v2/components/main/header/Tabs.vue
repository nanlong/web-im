<template lang="html">
  <div class="zheye-app-main-header-tabs">
    <span class="zheye-app-main-header-tab"
      v-for="tab in tabs"
      :class="{is_current: current_tab == tab.name}" @click="switch_to(tab)">
      {{ tab.text }}
    </span>
  </div>
</template>

<script>
export default {
  name: "MainHeaderTabs",
  computed: {
    current_tab () {
      return this.$store.state.main.current_tab
    }
  },
  data: () => {
    return {
      tabs: [
        {
          text: "对话",
          name: "dialog",
          icon: "",
        },
        {
          text: "好友",
          name: "friend",
          icon: "",
        }
      ]
    }
  },
  methods: {
    switch_to: function(tab) {
      this.$store.commit("set_main_current_tab", tab.name)
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-main-header-tabs {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: box;
    display: -webkit-box;
    display: -moz-box;
    -webkit-box-pack:center;
    -moz-box-pack:center;
    -webkit-box-align:center;
    -moz-box-align:center;
  }
  .zheye-app-main-header-tab {
    display: inline-block;
    margin: 0 10px;
    cursor: pointer;
  }
  .is_current {
    color: rgb(18, 183, 245);
  }
</style>
