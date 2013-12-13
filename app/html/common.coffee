
markup = ({i}) ->
  doctype 5

  html ->
    head ->
      title -> i.title

    body i.body