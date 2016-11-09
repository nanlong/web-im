<template lang="html">
  <div class="">
    <MainDialogTabLeft></MainDialogTabLeft>
    <MainDialogTabRight></MainDialogTabRight>
  </div>
</template>

<script>
import MainDialogTabLeft from "./dialog_tab/Left.vue"
import MainDialogTabRight from "./dialog_tab/Right.vue"

export default {
  name: "MainDialogTab",
  components: {MainDialogTabLeft, MainDialogTabRight}
}
</script>

<style lang="css">
</style>
