
this.module =
  inline: []
  markup: []
  master:
    head: ->
      script type:"text/javascript",src:"/content?schema=1"
      script type:"text/javascript",src:"/socket-meta"

      title "My Title"

    body: ->
      div "My Content"
