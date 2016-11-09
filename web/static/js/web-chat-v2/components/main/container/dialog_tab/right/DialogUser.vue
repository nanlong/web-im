<template lang="html">
  <div class="">
    <DialogUserHeader></DialogUserHeader>
    <DialogUserBody></DialogUserBody>
    <DialogUserFooter></DialogUserFooter>
  </div>
</template>

<script>
import DialogUserHeader from "./dialog_user/Header.vue"
import DialogUserBody from "./dialog_user/Body.vue"
import DialogUserFooter from "./dialog_user/Footer.vue"

export default {
  name: "DialogUser",
  components: {DialogUserHeader, DialogUserBody, DialogUserFooter},
  computed: {
    selected () {
      return this.$store.main.dialog.left.selected
    }
  }
}
</script>

<style lang="css">
</style>
