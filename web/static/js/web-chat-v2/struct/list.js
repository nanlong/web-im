class List {
  constructor (set) {
    // this.set = new WeakSet()
    this.set = set
    this.data = []
    this.current = null
  }

  set (data) {
    var self = this
    data.map(function(item) {
      self.add(item)
    })
  }

  add (item) {
    if (! this.set.has(item.id)) {
      this.set.add(item.id)
      this.data.push(item)
    }
  }

  delete (item) {
    let index = this.data.findIndex((value) => value.id == item.id)

    if (index > -1) {
      this.set.delete(item.id)
      this.data.splice(index, 1)

      if (this.current.id == item.id) {
        this.selected()
      }
    }
  }

  selected (item) {
    if (! item || ! this.set.has(item.id)) {
      this.current = null
    }
    else {
      this.current = item
    }
  }

  size () {
    return this.set.size
  }
}

export default List
