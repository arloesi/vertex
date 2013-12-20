
common = require "./common"

common.markup ->
  master
    name: "main"
    title: "My Title"
    body: -> div "My Content"

