
model ->
  class this.Model
    constructor: ->
      self = this

      this.menu = new Menu "menu","content",[{title:"Home",target:"home"},{title:"Inventory",target:"inventory"}]

      this.complete = ->
        self.menu.show "inventory"

master
  heading: "Main Page"
  content: ->
    div "data-bind":"init:complete", ->
      menu model:"menu",layout:"left.horizontal"

      div "#content", ->
        div "#home", ->
          p "Home"

        div "#inventory", inventory
