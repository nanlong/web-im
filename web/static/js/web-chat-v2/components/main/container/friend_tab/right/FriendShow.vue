<template lang="html">
  <div class="zheye-app-friend-show">
    <div v-if="selected">
      <article class="zheye-app-friend-show-avatar">
        <img :src="selected.avatar" :alt="selected.name" :title="selected.name" />
      </article>
      <div class="zheye-app-friend-show-info">
        <ul>
          <li>
            <span>昵称：</span>
            <div class="zheye-app-friend-name">
              {{ selected.name }}
            </div>
          </li>
          <li>
            <span>签名：</span>
            <div class="zheye-app-friend-bio">
              {{ selected.bio }}
            </div>
          </li>
        </ul>
      </div>
      <div class="zheye-app-friend-show-dialog">
        <span @click="open_dialog">发起会话</span>
      </div>
    </div>

  </div>
</template>

<script>
export default {
  name: "FriendShow",
  computed: {
    selected () {
      return this.$store.state.main.friend.left.selected
    }
  },
  methods: {
    open_dialog: function() {
      this.$store.commit("open_dialog", this.selected)
    }
  }
}
</script>

<style lang="css" scoped>
  .zheye-app-friend-show-avatar {
    text-align: center;
    padding: 30px 0;
  }
  .zheye-app-friend-show-avatar img {
    width: 60px;
    height: 60px;
    border-radius: 100%;
  }
  .zheye-app-friend-show-info {
    width: 320px;
    height: 200px;
    overflow-y: auto;
    margin: 0 auto;
  }
  .zheye-app-friend-show-info span {
    float: left;
  }
  .zheye-app-friend-show-info div {
    margin-left: 40px;
  }
  .zheye-app-friend-show-dialog {
    padding-top: 20px;
    text-align: center;
  }
  .zheye-app-friend-show-dialog span {
    display: inline-block;
    width: 240px;
    height: 36px;
    background: rgb(0, 182, 248);
    color: #fff;
    border-radius: 3px;
    text-align: center;
    line-height: 36px;
    cursor: pointer;
  }
  .zheye-app-friend-show-dialog span:hover {
    background: rgb(0, 182, 252);
  }
</style>
