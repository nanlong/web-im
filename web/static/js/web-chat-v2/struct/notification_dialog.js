import Vue from "vue"

class NotificationDialog {
  constructor () {
    this.total = 0
    this.statistics_set = new Set()
    this.statistics = {}
  }
  
  add (notification) {
    this.total += 1
    this.increment_statistics(notification.user.id)
  }

  increment_statistics (key) {
    this.init_statistics(key)
    Vue.set(this.statistics, key, this.statistics[key] + 1)
  }

  reset () {
    this.reset_total()
    this.reset_statistics()
  }

  reset_total () {
    this.total = 0
  }

  reset_statistics (key) {
    if (this.statistics_set.has(key)) {
      Vue.set(this.statistics, key, 0)
    }
  }

  init_statistics (key) {
    if (! this.statistics_set.has(key)) {
      this.statistics_set.add(key)
      Vue.set(this.statistics, key, 0)
    }
  }

  noread (key) {
    this.init_statistics(key)
    return this.statistics[key]
  }

}

export default NotificationDialog
