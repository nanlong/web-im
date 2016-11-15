<template lang="html">
  <div class="zheye-app-dialog-user-header" v-if="selected">
    <span class="zheye-app-dialog-user-header-name">
      {{ selected.name }}
    </span>

    <span class="zheye-button-add-friend" v-if="is_friend" @click="add_friend">+ 加为好友</span>
  </div>
</template>

<script>
export default {
  name: "DialogUserHeader",
  data: function() {
    return {
      is_friend: false,
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
  watch: {
    selected: function(user, old_user) {
      if (!user) {
        return
      }

      if (user.id == "notification:friend") {
        return
      }

      if (old_user && old_user.id == user.id) {
        return
      }

      this.channel.push("is_friend", user)

      this.channel.on("is_friend", resp => {
        this.is_friend = resp.is_friend
      })
    }
  },
  methods: {
    add_friend: function() {
      this.channel.push("add_friend", this.selected)
      alert("好友请求已发送，请等待对方确认")
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-dialog-user-header {
    height: 45px;
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    background: #fff;
  }
  .zheye-app-dialog-user-header-name {
    line-height: 45px;
    margin-left: 10px;
  }
  .zheye-button-add-friend {
    display: inline-block;
    position: absolute;
    top: 11px;
    right: 10px;
    cursor: pointer;
    background: #23d160;
    padding: 2px 5px;
    font-size: 12px;
    color: #fff;
    border-radius: 3px;
  }
  .zheye-button-add-friend:hover {
    background: #20bc56;
  }
</style>
