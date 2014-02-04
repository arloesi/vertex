
class Model
  constructor: ->
    self = this

    this.items = ko.observableArray()

    this.items [
      {name:"Name 1", value:"Value 1"},
      {name:"Name 2", value:"Value 2"},
      {name:"Name 3", value:"Value 3"}]

    this.onAddOne = ->
      length = self.items().length
      self.items.push {name:"Name "+length, value:"Value "+length}

$ ->
  ko.applyBindings new Model(), (document.getElementById "main")
