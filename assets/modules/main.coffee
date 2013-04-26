
model ->
  class this.Model
    constructor: ->
      self = this

      this.menu = new Menu
        menu: "menu"
        container: "content"
        target: "inventory"
        items: [{title:"Home",target:"home"},{title:"Inventory",target:"inventory"}]

      this.complete = ->
        self.menu.show "inventory"

master
  heading: "Main Page"
  content: ->
    div ->
      div "table.fill-horizontal", ->
        div ->
          h1 "Financials"
          menu model:"menu",layout:"right.horizontal"

      div "#content", ->
        div "#home", -> p "Home"
        div "#inventory", "data-bind":"with:newInventory()", inventory
