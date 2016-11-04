<template lang="html">
  <header class="chat-dialog-header">
    <div class="chat-dialog-header-user is-clearfix">
      <article class="chat-dialog-header-avatar is-pulled-left">
        <img :src="currentUser.avatar" :alt="currentUser.name" :title="currentUser.name" />
      </article>
      <div class="media-content">
        <h5 class="chat-dialog-header-name">
          {{ currentUser.name }}
          <span class="chat-dialog-is-temp" v-show="!currentUser.is_firend">临时会话</span>
        </h5>
        <span class="chat-dialog-add-firend is-pulled-right" v-show="!currentUser.is_firend" @click="add_firend">+ 添加好友</span>
        <p class="chat-dialog-header-bio">
          {{ currentUser.bio }}
        </p>
      </div>
    </div>

    <div class="chat-dialog-header-tools">
      <chat-dialog-close></chat-dialog-close>
    </div>
  </header>
</template>

<script>
import ChatDialogClose from "./Close.vue"

export default {
  name: "dialog_header",
  props: ["currentUser"],
  components: {
    ChatDialogClose,
  },
  methods: {
    add_firend: function() {
      let channel = this.$store.state.channel.self
      channel.push("add_firend", this.currentUser)

      alert("添加好友请求已发送，请等待对方确认")
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-dialog-header {
    height: 80px;
    background: #F8F8F8;
    position: relative;
  }
  .chat-dialog-is-temp {
    font-size: 12px;
    color: #00d1b2;
  }
  .chat-dialog-header-user {
    padding: 15px 0 15px 20px !important;
  }
  .chat-dialog-header-avatar {
    margin-right: 10px !important;
  }
  .chat-dialog-header-avatar img {
    width: 50px;
    height: 50px;
    border-radius: 100%;
  }
  .chat-dialog-header-name {
    font-size: 18px;
    line-height: 30px;
  }
  .chat-dialog-header-bio {
    font-size: 12px;
    line-height: 20px;
    color: #999;
    overflow:hidden;
    text-overflow:ellipsis;
    white-space:nowrap;
  }
  .chat-dialog-header-tools {
    position: absolute;
    top: 15px;
    right: 20px;
  }
  .chat-dialog-add-firend {
    margin-right: 10px !important;
    padding: 3px 5px !important;
    background: #00d1b2;
    color: #fff;
    cursor: pointer;
  }
</style>
