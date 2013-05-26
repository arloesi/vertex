
main = ->
  $ ->
    $.user = ($.content.factory.create "/detail/user").extend url:"/content/detail/user"
    $.users = new ($.content.collection.extend model:$.content.factory.create "/simple/user",url:"/content/simple/user")

  class this.Main
    constructor: (i) ->
      self = this

      $.services.security.events.authenticated.subscribe ({error,message}) -> self.message message

      this.save = ->
        $.users.save()

      this.destroy = (i) ->
        user = new $.user id:i.id()
        user.destroy success: -> $.users.fetch()

      # Validation fails because id is null
      this.create = new Model new $.user(),
        save: (i) -> i.model().save null, success: -> $.users.fetch()

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
  markup: []

  master: master
    title: "Vert.x"

    header: ->
      menu id:"menu",container:"#content,#form",items:"items"
      div "#form.navbar-form.pull-right", ->
        div "administrator", ->
          comment "ko with:create"
          input type:"text",placeholder:"Username","data-bind":"value:name"
          input type:"text",placeholder:"Email","data-bind":"value:mail"
          input type:"password",placeholder:"Password","data-bind":"value:decryptedPassword"
          button "btn","data-bind":"click:save","Create"
          comment "/ko"
          button "btn","data-bind":"click:save","Save"
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
            div ->
              button "btn","data-bind":"click:$parent.destroy","Delete"
          comment "/ko"
      div "wrap.user","data-bind":"text:message"


