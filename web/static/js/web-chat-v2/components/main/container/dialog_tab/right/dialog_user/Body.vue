<template lang="html">
  <div class="zheye-app-dialog-user-body" id="zheye-app-dialog-container">
    <div class="zheye-app-dialog-msg">
      <span @click="open_dialog_history">更多数据进入聊天记录查看<span>
    </div>
    <div class="zheye-app-dialog-item"
      v-for="item in data"
      :class="{self: item.user.id == current_user.id}">
      <article class="zheye-app-dialog-item-avatar">
        <img :src="item.user.avatar" :alt="item.user.name" :title="item.user.name" />
      </article>

      <div class="zheye-app-dialog-item-container">
        <div class="zheye-app-dialog-item-info">
          <span class="zheye-app-dialog-item-username">{{ item.user.name }}</span>
          <span class="zheye-app-dialog-item-inserted">{{ item.inserted_at | date }}</span>
        </div>
        <div class="zheye-app-dialog-item-content">
          {{ item.content }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "DialogUserBody",
  computed: {
    channel () {
      return this.$store.state.channel.dialog
    },
    current_user () {
      return this.$store.state.current_user
    },
    selected () {
      return this.$store.state.main.dialog.left.selected
    },
    data () {
      return this.$store.state.main.dialog.right.data
    }
  },
  watch: {
    channel: function(dialog_channel, old_channel) {
      if (!dialog_channel) {
        return
      }

      if (old_channel && old_channel.topic == dialog_channel.topic) {
        return
      }

      dialog_channel.push("get_dialog_history")
      dialog_channel.on("get_dialog_history", resp => {
        this.$store.commit("set_main_dialog_right_data", resp.data)
        this.scrolling()
      })

      dialog_channel.on("shout", resp => {
        this.$store.commit("push_main_dialog_right_data", resp)
        this.scrolling()
      })
    }
  },
  methods: {
    scrolling: function() {
      setTimeout(function() {
        let chat = document.getElementById('zheye-app-dialog-container')
        chat.scrollTop = chat.scrollHeight
      }, 100)
    },
    open_dialog_history: function() {
      alert("等待实现")
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-dialog-user-body {
    position: absolute;
    top: 45px;
    left: 0;
    right: 0;
    bottom: 120px;
    overflow-y: auto;
  }
  .zheye-app-dialog-msg {
    text-align: center;
  }
  .zheye-app-dialog-msg span {
    display: inline-block;
    background: rgb(248, 248, 248);
    padding: 3px 10px;
    border-radius: 3px;
    color: #999;
    cursor: pointer;
    font-size: 12px;
  }
  .zheye-app-dialog-item {
    padding: 10px;
  }
  .zheye-app-dialog-item-avatar {
    float: left;
  }
  .zheye-app-dialog-item-avatar img {
    width: 40px;
    height: 40px;
    border-radius: 100%;
  }
  .zheye-app-dialog-item-container {
    margin: 0 50px;
  }
  .zheye-app-dialog-item-content {
    display: inline-block;
    background: #eee;
    padding: 5px 15px;
    word-break: break-all;
    border-radius: 3px;
  }
  .zheye-app-dialog-item-info {
    padding: 5px 0;
  }
  .zheye-app-dialog-item-username {
    float: left;
    margin: 0 5px 0 0;
  }
  .zheye-app-dialog-item-inserted {
    font-size: 12px;
    color: #999;
  }
  .zheye-app-dialog-item.self {
    text-align: right;
  }
  .zheye-app-dialog-item.self .zheye-app-dialog-item-avatar {
    float: right;
  }
  .zheye-app-dialog-item.self .zheye-app-dialog-item-username {
    float: right;
    margin: 0 0 0 5px;
  }
  .zheye-app-dialog-item.self .zheye-app-dialog-item-content {
    background: #33DF83;
    color: #fff;
    text-align: left;
  }
</style>
