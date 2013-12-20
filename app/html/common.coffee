
cc = require "coffeecup"

locals =
  master: (i) ->
    doctype 5

    html ->
      head ->
        title -> i.title

      body i.body


this.markup = (i) ->
 console.log (cc.render i, hardcode: locals, optimize: false)
