
main = ->
  $ ->
    $.services.security.events.authenticated.subscribe ({error,message}) -> alert message
    $.services.security.events.created.subscribe -> $.users.fetch()

    $.user = $.content.factory.create "/detail/user"
    $.users = new ($.content.collection.extend model:$.user,url:"/content/detail/user")

  class this.Main
    constructor: (i) ->
      self = this

      this.login = ->
        $.services.security.authenticate name:self.name(),pass:self.pass()

      this.create = ->
        $.services.security.create name:self.name(),mail:self.name()+"@mail.com",pass:self.pass()

      this.save = ->
        $.users.save()

      this.name = ko.observable()
      this.pass = ko.observable()

      this.users = kb.collectionObservable $.users

      this.items = [{title:"Administrator",target:".administrator"},{title:"User",target:".user"}]

  $ ->
    ko.applyBindings new Main()
    $.users.fetch()

this.module =
  inline: [main]

  markup:
    user: ->
      div "user", ->
        label "Name:&nbsp"
        input type:"text","data-bind":"value:name"

  master: master
    title: "Sample"

    header: ->
      menu id:"menu",container:"#content",items:"items"
      div "navbar-form.pull-right", ->
        input type:"text",placeholder:"Username","data-bind":"value:name"
        input type:"password",placeholder:"Password","data-bind":"value:pass"
        button "btn","data-bind":"click:login","Sign In"
        button "btn","data-bind":"click:create","Register"

    content: ->
      div "wrap.administrator", ->
        div "table.left", ->
          div ->
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
          comment "/ko"
      div "wrap.user", ->
        text "User"


