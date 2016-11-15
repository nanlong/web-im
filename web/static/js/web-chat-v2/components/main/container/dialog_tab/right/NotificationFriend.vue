<template lang="html">
  <div class="zheye-app-notification-friend"
    v-show="selected && selected.id == 'notification:friend'">

    <div class="zheye-app-notification-item" v-for="request in data">
      <article class="zheye-app-notification-item-avatar">
        <img :src="request.from_user.avatar" :alt="request.from_user.name" :title="request.from_user.name" />
      </article>
      <div class="zheye-app-notification-item-message">
        {{ request.from_user.name }} 请求加为好友
        <div class="zheye-app-notification-item-button">
          <span class="zheye-app-button-confirm" v-if="! request.is_confirmed" @click="add_friend_confirmed(request)">确定</span>
          <span v-if="request.is_confirmed">已确认</span>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: "NotificationDialog",
  data: function() {
    return {
      data: []
    }
  },
  computed: {
    selected () {
      return this.$store.state.main.dialog.left.current
    },
    channel () {
      return this.$store.state.channel.self
    }
  },
  created: function() {
    this.channel.on("get_notification_friend", resp => {
      this.data = resp.data
    })
  },
  watch: {
    selected: function(selected, _) {
      if (selected && selected.id == 'notification:friend') {
        this.channel.push("get_notification_friend")
      }
    }
  },
  methods: {
    add_friend_confirmed: function(request) {
      request.is_confirmed = true
      this.channel.push("add_friend:confirmed", request)
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-notification-friend {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    overflow-y: auto;
  }
  .zheye-app-notification-item {
    margin: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
  }
  .zheye-app-notification-item-avatar {
    float: left;
  }
  .zheye-app-notification-item-avatar img {
    width: 40px;
    height: 40px;
    border-radius: 100%
  }
  .zheye-app-notification-item-message {
    height: 40px;
    margin-left: 60px;
  }
  .zheye-app-notification-item-button {
    text-align: right;
  }
  .zheye-app-button-confirm {
    padding: 3px 5px;
    border-radius: 3px;
    cursor: pointer;
    color: #fff;
    font-size: 12px;
  }
  .zheye-app-button-confirm {
    background: #23d160;
  }
  .zheye-app-button-confirm:hover {
    background: #20bc56;
  }
</style>
