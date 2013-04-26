
common =
  styles: ["layout"]
  scripts:
    ["library/jquery-ui/js/jquery","library/jquery-ui/js/jquery-ui"
    ,"library/scripts/sockjs","library/scripts/cookie","library/scripts/date"
    ,"library/scripts/underscore","library/scripts/backbone"
    ,"library/scripts/knockout","library/scripts/knockback"]

master = ({content,heading})->
  markup = render ->
    html ->
      head ->
        title heading

      for i in common.styles
        link rel:"stylesheet", href:"/static/styles/#{i}.css"

      for i in common.scripts
        script type:"text/javascript", src:"/static/#{i}.js"

      body content

  process.stdout.write markup
