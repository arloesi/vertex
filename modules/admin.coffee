
main = ->
  class this.SignIn
    constructor: ->
      self = this

      $ -> security.events.authenticated.subscribe ({error,message}) -> self.message message

      this.name = ko.observable()
      this.pass = ko.observable()
      this.message = ko.observable()

      this.signin = -> security.authenticate name:self.name(),pass:self.pass()

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
  div "table.left.navbar-form", ->
    div "data-bind":"with:member", ->
      div -> input type:"text",placeholder:"Username","data-bind":"value:name"
      div -> input type:"text",placeholder:"Email","data-bind":"value:mail"
      div -> input type:"password",placeholder:"Password","data-bind":"value:decryptedPassword"
      div -> input "btn",type:"button",value:"Create","data-bind":"click:save"

    comment "ko foreach:members"
    div ->
      div "data-bind":"text:name"
      div "data-bind":"text:mail"
      div ""
      div -> input "btn",type:"button",value:"Remove","data-bind":"click:$parent.remove"
    comment "/ko"

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
