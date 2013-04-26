
models = []
model = (i) -> models.push i

model ->
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
        $("#"+container+" > *").hide()
        $("#"+container+" > ##{i.target}").show()

      this.complete = ->
        self.show target

menu = ({id,layout,items,container,model,format}) ->
  model ?= "new Menu('#{id}','#{container}',#{items})"
  layout ?= "horizontal"
  format ?= -> div -> a "item",href:"#","data-bind":"text:title,click:$parent.show,css:{active:target==$parent.active()}"

  text "<!-- ko with:#{model} -->"
  div "menu.#{layout}","data-bind":"foreach:items,init:complete,attr:{id:id}", format
  text "<!-- /ko -->"

common =
  styles: ["layout","common"]
  scripts:
    ["library/jquery-ui/js/jquery","library/jquery-ui/js/jquery-ui"
    ,"library/scripts/sockjs","library/scripts/cookie","library/scripts/date"
    ,"library/scripts/underscore","library/scripts/backbone"
    ,"library/scripts/knockout","library/scripts/knockback"
    ,"scripts/kernel","scripts/binding"]

master = ({content,heading,model})->
  model ?= "Model"

  markup = render ->
    html ->
      head ->
        runtime()

        title heading

        for i in common.styles
          link rel:"stylesheet", href:"/static/styles/#{i}.css"

        for i in common.scripts
          script type:"text/javascript", src:"/static/#{i}.js"

        coffee i for i in models
        script type:"text/javascript", "$(function() {ko.applyBindings(new #{model}())})"

      body content

  process.stdout.write markup
