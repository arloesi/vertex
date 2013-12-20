
common = require "./common"

common.markup ->
  master
    name: "user"
    title:  "User Title"
    body: ->
      div "User Content"
