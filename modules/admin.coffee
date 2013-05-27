
main = ->
  $.member = $.content.factory.create "/detail/member"
  $.members = new ($.content.collection.extend
    model:$.content.factory.create "/simple/member"
    url:"/content/simple/member")

  class this.SignIn
    constructor: ->
      self = this

      $ -> $.services.security.events.authenticated.subscribe ({error,message}) -> self.message message

      this.name = ko.observable()
      this.pass = ko.observable()
      this.message = ko.observable()

      this.signin = -> $.services.security.authenticate name:self.name(),pass:self.pass()

  class this.Controller
    Router: Backbone.Router.extend
      routes:
        ":id":"main"

    constructor: ->
      super()

      self = this

      this.menu =
        [{title:"Members",target:"members"}
        ,{title:"Accounts",target:"accounts"}
        ,{title:"Venues",target:"venues"}]

      this.active = ko.observable "members"
      this.router = new this.Router()

      this.router.on "route:main", (i) ->
          console.log "id: #{i}"

      Backbone.history.start()

this.module =
  inline: [main]

  markup:
    "account.html": ->
      div "account", "My Account"

    "venue.html": ->
      div "venue", "My Venue"

    "members.html": ->
      h4 -> "Members"

    "accounts.html": ->
      h4 -> "Accounts"

    "venues.html": ->
      h4 -> "Venues"

  master: master
    title: "Administrator"

    header: ->
      ul "menu.nav.horizontal","data-bind":"foreach:menu", ->
        li -> a "item",href:"#","data-bind":"text:title,attr:{href:'#'+target}"

      div "#form.navbar-form.pull-right","signin","data-bind":"with:new SignIn()", ->
        input type:"text",placeholder:"Username","data-bind":"value:name"
        input type:"password",placeholder:"Password","data-bind":"value:pass"
        button "btn","data-bind":"click:signin","Sign In"

    content: ->
      div "#content.wrap", "data-bind":"foreach:menu", ->
        comment "ko if:target==$parent.active()"
        div "data-bind":"template:target+'.html',attr:{id:target}"
        comment "/ko"
