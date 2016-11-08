import Vue from "vue"
import date from "./filters/date"
import store from "./store"
import App from "./components/App.vue"
import ChatButton from "./components/Button.vue"

Vue.filter("date", date)

new Vue({
  el: "#zheye-web-chat",
  store,
  render: h => h(App)
})

let buttons = document.querySelectorAll('.zheye-web-chat-button')

buttons.forEach(function(element) {
  new Vue({
    el: element,
    store,
    components: {
      ChatButton
    }
  })
})
