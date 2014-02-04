
common = require "./common"

common.markup ->
  master
    name: "main"
    title: "My Title"
    body: ->
      div "#main", ->
        div "#header.horizontal.center", ->
          h4 "Knockout Demo"
          input "type":"button", "value":"Add One", "data-bind":"click:onAddOne"
        div "#content.horizontal.center", ->
          div -> div "#items.table", "data-bind":"foreach:items", ->
            div ->
              div "#.item", "data-bind":"text:name"
              div "#.item", "data-bind":"text:value"


