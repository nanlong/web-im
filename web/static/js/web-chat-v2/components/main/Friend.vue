<template lang="html">
  <div class="zheye-app-main-friend" :class="{selected: selected_id == user.id}" @click="selected">
    <article class="zheye-app-main-friend-avatar">
      <img :src="user.avatar" :alt="user.name" :title="user.name" />
    </article>
    <div class="zheye-app-main-friend-info">
      <div class="zheye-app-main-friend-name">
        {{ user.name }}
      </div>
      <div class="zheye-app-main-friend-bio">
        {{ user.bio }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "MainFirend",
  props: ["user"],
  computed: {
    selected_id () {
      return this.$store.state.main.friend_selected_id
    }
  },
  methods: {
    selected: function() {
      this.$store.commit("set_main_friend_selected_id", this.user.id)
    },
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-main-friend {
    padding: 15px;
    height: 70px;
  }
  .zheye-app-main-friend.selected {
    background: rgb(240, 240, 240);
  }
  .zheye-app-main-friend-avatar {
    float: left;
  }
  .zheye-app-main-friend-avatar img {
    width: 40px;
    height: 40px;
    border-radius: 100%;
  }
  .zheye-app-main-friend-info {
    margin-left: 50px;
  }
  .zheye-app-main-friend-name {
    padding-top: 3px;
  }
  .zheye-app-main-friend-bio {
    font-size: 12px;
    color: #999;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
</style>
