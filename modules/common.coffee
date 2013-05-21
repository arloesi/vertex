
inline =
  menu: ->
    class this.Menu
      constructor: ({menu,container,items,target}) ->
        target ?= items[0].target

        self = this

        this.id = menu
        this.items = items
        this.active = ko.observable(items[0].target)

        this.show = (i) ->
          if typeof i == "string"
            for x in self.items
              if x.target == i
                i = x
                break

          self.active i.target


          $(container+" > *").hide()
          $(container+" > #{i.target}").show()

        this.complete = ->
          self.show target

this.menu = ({id,layout,items,container,model,format}) ->
  model ?= "new Menu({menu:'#{id}',container:'#{container}',items:#{items}})"
  layout ?= "horizontal"
  format ?= -> div -> a "item",href:"#","data-bind":"text:title,click:$parent.show,css:{active:target==$parent.active()}"

  text "<!-- ko with:#{model} -->"
  div "menu.#{layout}","data-bind":"foreach:items,init:complete,attr:{id:id}", format
  text "<!-- /ko -->"

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
            div "nav-collapse.collapse", ->
              ul "nav", ->
                li -> a href:"#", "Home"
                li -> a href:"#about", "About"
              i.header()

      div "#content.center", i.content

this.module =
  inline: [inline.menu]
  markup: []
