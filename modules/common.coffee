
common = ->
  this.security = services.security

  class this.View extends kb.ViewModel
    constructor: (model,ctor) ->
      super model
      ctor.call this

  class this.Menu
    constructor: ({items,target}) ->
      target ?= items[0].target

      self = this
      this.items = items
      this.active = ko.observable(items[0].target)

      this.show = (i) ->
        if typeof i == "string"
          for x in self.items
            if x.target == i
              i = x
              break

        self.active i.target
        true

      this.complete = ->
        self.show target

main = -> $ ->
  this.controller = new Controller()
  ko.applyBindings this.controller

  if typeof this.controller.initialize == "function"
    this.controller.initialize()

this.nbsp = ->
  text "&nbsp;"

this.menu = ({id,layout,model,format}) ->
  id = "#{id}." if id

  model ?= "menu"
  layout ?= "nav.horizontal"
  format ?= -> li -> a "item",
    href:"#","data-bind":"text:title,click:$parent.show,css:{active:target==$parent.active()},attr:{href:'#'+target}"

  text "<!-- ko with:#{model} -->"
  ul "#{id}menu.#{layout}","data-bind":"foreach:items,init:complete", format
  text "<!-- /ko -->"

this.links = (items) ->
  ul "nav.horizontal", ->
    li -> a href:"##{i.target}",i.title for i in items

this.master = (i) ->
  head: ->
    script type:"text/javascript",src:"/content?schema=1"
    script type:"text/javascript",src:"/socket-meta"

    title i.title

  body: ->
    div "#container", ->
      div "navbar.navbar-inverse.navbar-fixed-top", ->
        div "navbar-inner", ->
          div "container", ->
            a "brand", href:"#", i.title
            div "nav-collapse.collapse", i.header
      div "center", i.content

this.module =
  inline: [common,main]
  markup: []
