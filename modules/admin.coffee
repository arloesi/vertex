
main = ->
  $.user = ($.content.factory.create "/detail/user").extend url:"/content/detail/user"
  $.users = new ($.content.collection.extend model:$.content.factory.create "/simple/user",url:"/content/simple/user")

  class this.SignIn
    constructor: ->
      self = this

      $.services.security.events.authenticated.subscribe ({error,message}) -> self.message message

      this.signin =
        name: ko.observable()
        pass: ko.observable()
        exec: -> $.services.security.authenticate
          name:self.signin.name()
          pass:self.signin.pass()

      this.message = ko.observable()

  class this.Administrator
    constructor: ->
      self = this

      this.save = ->
        $.users.save()

      this.destroy = (i) ->
        user = new $.user id:i.id()
        user.destroy success: -> $.users.fetch()

      this.create = new View new $.user(),
        save: (i) ->
          i.model().save null,
            success: -> $.users.fetch()
            error: -> alert "save user failed"

      this.users = kb.collectionObservable $.users

  controller = (model,element) ->

  this.initialize = ->
    $.users.fetch()

this.module =
  inline: [main]

  markup:
    "profile.html": ->
      div "profile", "My Profile"

    "account.html": ->
      div "account", "My Account"

    "administrator.html": ->
      div "administrator", ->
        div "table.left", ->
          div "data-bind":"if:users().length>0", ->
            div "Name"
            div "Email"
          comment "ko foreach:users"
          div ->
            div ->
              input type:"text","data-bind":"value:name"
              text "&nbsp"
            div ->
              input type:"text","data-bind":"value:mail"
              text "&nbsp"
            div ->
              button "btn","data-bind":"click:$parent.destroy","Delete"
          comment "/ko"

  master: master
    title: "Administrator"

    header: ->
      menu id:"menu",container:"#content,#form",items:"items"

      div "#form.navbar-form.pull-right","signin","data-bind":"with:new SignIn()", ->
        input type:"text",placeholder:"Username","data-bind":"value:name"
        input type:"password",placeholder:"Password","data-bind":"value:pass"
        button "btn","data-bind":"click:signin","Sign In"

    content: ->
      div "wrap","data-bind":"inject:controller",
