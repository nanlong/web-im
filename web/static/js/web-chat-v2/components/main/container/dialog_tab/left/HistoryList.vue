<template lang="html">
  <div class="">
    <History v-for="history in data" :history="history"></History>
  </div>
</template>

<script>
import History from "./History.vue"

export default {
  name: "HistoryList",
  components: {History,},
  computed: {
    data () {
      return this.$store.state.main.dialog.left.data
    }
  }
}
</script>

<style lang="css">
</style>
