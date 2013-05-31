
main = ->
  message = ko.observable()

  class this.SignIn
    constructor: ->
      self = this

      security.events.authenticated.subscribe (params) ->
        message params.message

      this.name = ko.observable()
      this.pass = ko.observable()

      this.signin = ->
        security.authenticate name:self.name(),pass:self.pass()

  class this.Members
    constructor: (controller) ->
      detail = content.factory.create "/detail/member"
      simple = content.factory.create "/simple/member"

      model = new detail()
      collection = new (content.collection.extend model:simple,url:"/content/simple/member")

      this.member = new View model, ->
        this.save = ->
          model.save null,success: ->
            model.clear().set model.defaults
            collection.fetch()

      this.members = kb.collectionObservable collection

      this.remove = (i) ->
        model = new simple id:i.id()
        model.destroy success: -> collection.fetch()

      this.message = message

      collection.fetch()

  class this.Controller
    Router: Backbone.Router.extend
      routes:
        ":id":"main"

    constructor: ->
      self = this

      this.menu =
        [{title:"Members",target:"members",data:new Members(this)}
        ,{title:"Accounts",target:"accounts",data:{}}
        ,{title:"Venues",target:"venues",data:{}}]

      this.active = ko.observable "members"
      this.router = new this.Router()
      this.router.on "route:main", self.active
      Backbone.history.start()

members = ->
  div "table.form.left", ->
    div "data-bind":"with:member", ->
      div -> input type:"text",placeholder:"Username","data-bind":"value:name"
      div -> input type:"text",placeholder:"Email","data-bind":"value:mail"
      div -> input type:"password",placeholder:"Password","data-bind":"value:decryptedPassword"
      div -> button "btn",type:"button","data-bind":"click:save","Create"

    comment "ko foreach:members"
    div ->
      div -> div "data-bind":"text:name"
      div -> div "data-bind":"text:mail"
      div -> div ""
      div -> button "btn",type:"button","data-bind":"click:$parent.remove","Remove"
    comment "/ko"
  div ->
    p "data-bind":"text:message"

this.module =
  inline: [main]

  markup:
    "members.html": members

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
        div "data-bind":"template:{name:target+'.html',data:data},attr:{id:target}"
        comment "/ko"
