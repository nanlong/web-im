<!-- 通知  -->
<template lang="html">
  <div class="chat-message" v-show="is_open" @click="open_dialog">
    <div class="chat-message-left" v-if="data">
      <img :src="data.user.avatar" :alt="data.user.name" :title="data.user.name" />
    </div>
    <div class="chat-message-content">
      收到新消息
    </div>
  </div>
</template>

<script>
export default {
  name: "message",
  computed: {
    is_open () {
      return this.$store.state.message.is_open
    },
    data () {
      return this.$store.state.message.data
    }
  },
  methods: {
    open_dialog: function() {
      this.$store.commit("close_message")
      this.$store.commit("open_dialog")
      this.$store.commit("push_dialog_user_list", this.data.user)
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-message {
    position:fixed;
    bottom: 5px;
    left: 50%;
    border: 1px solid #ccc;
    height: 54px;
    width: 170px;
    margin-left: -86px !important;
    cursor: pointer;
    background: #fff;
  }
  .chat-message-left {
    float: left;
    margin: 7px 0 0 10px !important;
  }
  .chat-message-left img {
    width: 40px;
    height: 40px;
    border-radius: 100%;
  }
  .chat-message-content {
    margin: 0 10px 0 60px !important;
    line-height: 54px;
    font-size: 14px;
  }
</style>
