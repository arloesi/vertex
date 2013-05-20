
this.master = (i) ->
  head: ->
    script type:"text/javascript",src:"/content?schema=1"
    script type:"text/javascript",src:"/socket-meta"

    title "i.title"

  body: ->
    div "XXX"