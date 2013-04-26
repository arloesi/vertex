
master =
  render ->
    html ->
      head ->
        title "My Title"
      body "module", ->
        div "main", ->
          text "My Content"

process.stdout.write master
