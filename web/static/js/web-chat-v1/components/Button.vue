<!-- 用户按钮 -->
<template lang="html">
  <span class="chat-button"
    :class="{online: is_online, offline: !is_online}"
    @click="open_dialog">
    跟Ta聊聊
  </span>
</template>

<script>
export default {
  name: "button",
  props: ["userId", "userName", "userAvatar", "userBio"],
  data: () => {
    return {
      is_online: true
    }
  },
  methods: {
    open_dialog: function() {
      this.$store.commit("open_dialog")
      let user = {
        id: this.userId,
        name: this.userName || "匿名用户",
        avatar: this.userAvatar || "https://gravatar.tycdn.net/avatar/940b5cb093d42537e6f93090e7262bab?d=wavatar&s=#200",
        bio: this.userBio || "这个家伙很懒，什么都没有留下",
        is_online: this.is_online
      }
      this.$store.commit("push_dialog_user_list", user)
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-button {
    display: inline-block;
    height: 30px;
    line-height: 30px;
    padding: 0 10px;
    background: #f6f6f6;
    text-align: center;
    cursor: pointer;
  }
  .chat-button.online {
    background-color: #23d160;
    border-width: 0;
    color: white;
  }
  .chat-button.online:hover, .chat-button.online:focus {
    background-color: #20bc56;
    border-color: transparent;
    color: white;
  }
  .chat-button.offline {
    background-color: whitesmoke;
    border-width: 0;
    color: #363636;
  }
  .chat-button.offline:hover, .chat-button.offline:focus {
    background-color: #e8e8e8;
    border-color: transparent;
    color: #363636;
  }
</style>
