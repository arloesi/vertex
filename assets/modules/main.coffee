
model ->
  class this.Model
    constructor: ->
      self = this

      this.menu = new Menu "menu","content",[{title:"Home",target:"home"},{title:"Search",target:"search"}]

      this.complete = ->
        self.menu.show "home"

master
  heading: "Main Page"
  content: ->
    div "data-bind":"init:complete", ->
      menu model:"menu",layout:"left.horizontal"

      div "#content", ->
        div "#home", ->
          p "Home"

        div "#search", ->
          p "Search"
