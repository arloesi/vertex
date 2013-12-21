
cc = require "coffeecup"

locals =
  master: (i) ->
    doctype 5

    html ->
      head ->
        title -> i.title

        script type:"text/javascript",src:"/static/scripts/#{i.name}.js"
        link rel:"stylesheet",type:"text/css",media:"all",href:"/static/styles/#{i.name}.css"

      body ".#{i.name}", ->
        div "#content", i.body

this.markup = (i) ->
  console.log (cc.render i, hardcode: locals)
