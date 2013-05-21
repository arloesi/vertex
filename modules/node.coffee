
main = ->
  $ ->
    $.user = ($.content.factory.create "/detail/user").extend url:"/content/detail/user"
    $.users = new ($.content.collection.extend model:$.user,url:"/content/simple/user")

  class this.Main
    constructor: (i) ->
      self = this

      $.services.security.events.authenticated.subscribe ({error,message}) -> self.message message

      this.save = ->
        $.users.save()

      this.create =
        name: ko.observable()
        mail: ko.observable()
        pass: ko.observable()
        exec: ->
          user = new $.user name:self.create.name(),mail:self.create.mail(),decryptedPassword:self.create.pass()
          user.save null,success: -> $.users.fetch()

      this.signin =
        name: ko.observable()
        pass: ko.observable()

        exec: -> $.services.security.authenticate
          name:self.signin.name()
          pass:self.signin.pass()

      this.message = ko.observable()

      this.users = kb.collectionObservable $.users
      this.items = [{title:"Administrator",target:".administrator"},{title:"Sign In",target:".user"}]

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
    title: "Vert.x"

    header: ->
      menu id:"menu",container:"#content,#form",items:"items"
      div "#form.navbar-form.pull-right", ->
        div "administrator","data-bind":"with:create", ->
          input type:"text",placeholder:"Username","data-bind":"value:name"
          input type:"text",placeholder:"Email","data-bind":"value:mail"
          input type:"password",placeholder:"Password","data-bind":"value:pass"
          button "btn","data-bind":"click:exec","Create"
        div "user","data-bind":"with:signin", ->
          input type:"text",placeholder:"Username","data-bind":"value:name"
          input type:"password",placeholder:"Password","data-bind":"value:pass"
          button "btn","data-bind":"click:exec","Sign In"

    content: ->
      div "wrap.administrator", ->
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
          comment "/ko"
      div "wrap.user","data-bind":"text:message"


