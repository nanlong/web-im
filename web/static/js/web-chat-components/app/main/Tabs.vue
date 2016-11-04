<template lang="html">
  <div class="chat-main-tabs">
    <ul class="is-clearfix">
      <li class="is-pulled-left has-text-centered"
        v-for="(tab, index) in tabs"
        :class="{active: index == current_index}"
        @click="toggle_tab(index)">
        <span>{{ tab.text }}</span>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "tabs",
  data: () => {
    return {
      tabs: [
        {text: "好友", name: "friend"},
        // {text: "群组", name: "group"},
        // {text: "历史", name: "history"},
      ],
      current_index: 0
    }
  },
  methods: {
    toggle_tab: function(index) {
      this.current_index = index
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-main-tabs {
    padding-top: 10px !important;
    position: absolute;
    top: 65px;
    left: 0;
    right: 0;
    height: 35px;
  }
  .chat-main-tabs li {
    width: 100%;
    height: 25px;
    border-bottom: 2px solid #F6F6F6;
    cursor: pointer;
  }
  .chat-main-tabs li.active {
    border-bottom-color: #3FDD86;
  }
</style>
