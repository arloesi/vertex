
master = ({content,heading})->
  markup = render ->
    html ->
      head ->
        title heading
      body content

  process.stdout.write markup
