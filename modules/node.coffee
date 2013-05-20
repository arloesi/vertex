
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
      div "navbar-form.pull-right", ->
        input type:"text",placeholder:"Username","data-bind":"value:name"
        input type:"password",placeholder:"Password","data-bind":"value:pass"
        button "btn","data-bind":"click:login","Sign In"
        button "btn","data-bind":"click:create","Register"

    content: ->
      div "wrap","data-bind":"foreach:users", ->
        div "table", ->
          div ->
            label "Name:&nbsp"
            input type:"text","data-bind":"value:name"
            input type:"button",value:"Save","data-bind":"click:$parent.save"


