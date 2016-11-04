<template lang="html">
  <div class="chat-main-firend is-clearfix" @click="open_dialog">
    <article class="chat-main-firend-avatar is-pulled-left">
      <img :src="firend.avatar" :alt="firend.name" :title="firend.name" />
    </article>
    <div class="chat-main-firend-info">
      <div class="chat-main-firend-name">
        {{ firend.name }}
      </div>
      <div class="chat-main-firend-bio">
        {{ firend.bio }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "firend",
  props: ["firend"],
  methods: {
    open_dialog: function() {
      this.$store.commit("open_dialog")
      this.$store.commit("push_dialog_user_list", this.firend)
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-main-firend {
    cursor: pointer;
    padding: 10px !important;
  }
  .chat-main-firend-avatar img {
    width: 40px;
    height: 40px;
    border-radius: 100%;
  }
  .chat-main-firend-bio {
    font-size: 12px;
    color: #999;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
  }
  .chat-main-firend-info {
    margin-left: 50px !important;
  }
</style>
