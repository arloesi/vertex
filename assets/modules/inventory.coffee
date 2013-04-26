
model ->
  this.newInventory = ->
    model = new Backbone.Model
      name: "Beverages"
      items: new Backbone.Collection [new Backbone.Model(name:"Beer"),new Backbone.Model(name:"Wine")]

    kb.viewModel model

inventory = ->
  h4 "data-bind":"text:name"

  div "data-bind":"foreach:items", ->
    p "data-bind":"text:name"
