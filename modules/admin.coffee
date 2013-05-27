
main = ->
  $.member = $.content.factory.create "/detail/member"
  $.members = new ($.content.collection.extend model:$.content.factory.create "/simple/member",url:"/content/simple/member")

  class this.SignIn
    constructor: ->
      self = this

      $ -> $.services.security.events.authenticated.subscribe ({error,message}) -> self.message message

      this.name = ko.observable()
      this.pass = ko.observable()
      this.message = ko.observable()

      this.signin = -> $.services.security.authenticate name:self.name(),pass:self.pass()

  class this.Controller extends Backbone.Router
    active: null

    routes:
      "account/:id":"account"
      "venue/:id":"venue"
      "*path": "main"

    constructor: ->
      self = this

      this.menu = new Menu items:
        [{title:"Members",target:"members"}
        ,{title:"Accounts",target:"accounts"}
        ,{title:"Venues",target:"venues"}]

      this.menu.active.subscribe (i) ->
        console.log "target: "+i

    load: (e) ->
      ko.removeNode active if active
      element.append (active=e)

this.module =
  inline: [main]

  markup:
    "account.html": ->
      div "account", "My Account"

    "venue.html": ->
      div "venue", "My Venue"

    "members-html": ->
      h4 -> "Members"

    "accounts-html": ->
      h4 -> "Accounts"

    "venues-html": ->
      h4 -> "Venues"

  master: master
    title: "Administrator"

    header: ->
      menu id:"#menu"

      div "#form.navbar-form.pull-right","signin","data-bind":"with:new SignIn()", ->
        input type:"text",placeholder:"Username","data-bind":"value:name"
        input type:"password",placeholder:"Password","data-bind":"value:pass"
        button "btn","data-bind":"click:signin","Sign In"

    content: ->
      div "#content.wrap", "data-bind":"foreach:menu.items", ->
        comment "ko if:target==$parent.menu.active()"
        # div "data-bind":"template:target+'-html',attr:{id:target}"
        comment "/ko"
