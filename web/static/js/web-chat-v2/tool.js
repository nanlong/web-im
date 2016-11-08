class Tool {

  // 是否是开发环境
  static is_dev() {
    let domain = this.get_domain()

    if (domain === "localhost" || domain === "127.0.0.1") {
      return true
    }

    return false
  }

  // 获取域名
  static get_domain() {
    if (document.domain === "127.0.0.1") {
      return document.domain
    }

    return document.domain.split(".").slice(-2).join(".")
  }

  static console_log() {
    if (arguments.length == 1) {
      console && console.log(arguments[0])
    }
    else if (arguments.length == 2) {
      console && console.log(arguments[0], arguments[1])
    }
  }
}

export default Tool
