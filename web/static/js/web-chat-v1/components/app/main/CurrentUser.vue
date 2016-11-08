<template lang="html">
  <div class="chat-main-current-user is-clearfix">
    <div class="is-clearfix">
      <article class="current-user-avatar">
        <img :src="current_user.avatar" :alt="current_user.name" :title="current_user.name" />
      </article>

    </div>
    <div class="current-user-bio">
      {{ current_user.bio }}
    </div>
  </div>
</template>

<script>
export default {
  name: "main-current-user",
  computed: {
    current_user () {
      return this.$store.state.current_user
    }
  }
}
</script>

<style lang="css" scoped>
  .chat-main-current-user {
    padding: 10px 15px 0 !important;
  }
  .current-user-avatar {
    width: 30px;
    height: 30px;
    float: left;
  }
  .current-user-avatar img {
    width: 100%;
    height: 100%;
    border-radius: 100%;
  }
  .current-user-bio {
    padding-top: 5px !important;
    color: #999;
    font-size: 12px;
  }
</style>
