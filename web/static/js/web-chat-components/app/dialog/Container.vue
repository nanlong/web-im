<template lang="html">
  <div id="chat-dialog-container" class="chat-dialog-container">
    <ul>
      <li class="chat-dialog-container-item" v-for="item in data" :class="{self: item.from_id == chat_current_user.id, other: item.from_id != chat_current_user.id}">
        <div class="chat-media is-clearfix">
          <article class="chat-media-avatar">
            <img :src="users[item.from_id].avatar" :alt="users[item.from_id].name" />
          </article>
          <div class="chat-media-content">
            <div class="chat-info">
              <span class="name">{{ users[item.from_id].name }}</span>
              <span class="time">{{ item.inserted_at | date }}</span>
            </div>
            <div class="chat-content">
              {{ item.content }}
            </div>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "dialog-container",
  data: () => {
    return {
      data: [],
      users: {}
    }
  },
  computed: {
    chat_current_user () {
      return this.$store.state.current_user
    },
    dialog_current_user () {
      return this.$store.state.dialog.current_user
    },
  },
  watch: {
    dialog_current_user: function(user, old_user) {
      if (old_user && old_user.id === user.id) {
        return
      }

      let channel = this.$store.state.channel.dialog

      this.users[user.id] = user
      this.data = []

      // 获取用户对话记录
      channel.push("get_notes", {})

      channel.on("get_notes", resp => {
        this.data = resp.data
        this.scrolling()
      })

      channel.on("shout", resp => {
        this.data.push(resp)
        this.scrolling()
      })
    }
  },
  created: function() {
    this.users[this.chat_current_user.id] = this.chat_current_user
  },
  methods: {
    scrolling: function() {
      setTimeout(function() {
        let chat = document.getElementById('chat-dialog-container')
        chat.scrollTop = chat.scrollHeight
      }, 100)
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-dialog-container {
    position: absolute;
    top: 80px;
    right: 0;
    bottom: 160px;
    left: 0;
    background: #fff;
    overflow-y: auto;
  }
  .chat-dialog-container-item {
    padding: 10px !important;
  }
  .chat-media-avatar img {
    width: 40px;
    height: 40px;
    border-radius: 100%;
  }
  .chat-content {
    display: inline-block;
    background: #eee;
    border-radius: 3px;
    padding: 5px 15px !important;
    word-break: break-all;
  }
  .chat-info .time {
    font-size: 12px;
    color: #999;
  }
  .chat-dialog-container-item.self {
    text-align: right;
  }
  .chat-dialog-container-item.self .chat-media-avatar {
    float: right;
    margin-left: 10px !important;
  }
  .chat-dialog-container-item.self .chat-media-content {
    margin-right: 50px !important;
  }
  .chat-dialog-container-item.self .chat-content {
    background: #33DF83;
    color: #fff;
    text-align: left;
  }
  .chat-dialog-container-item.self .name {
    float: right;
    margin-left: 10px !important;
  }
  .chat-dialog-container-item.other {
    text-align: left;
  }
  .chat-dialog-container-item.other .chat-media-avatar {
    float: left;
    margin-right: 10px !important;
  }
  .chat-dialog-container-item.other .chat-media-content {
    margin-left: 50px !important;
  }
  .chat-dialog-container-item.other .chat-content {
    background: #eee;
  }
  .chat-dialog-container-item.other .name {
    float: left;
    margin-right: 10px !important;
  }

</style>
