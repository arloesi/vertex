
main = ->
  $ ->
    $.services.security.events.authenticated.subscribe ({error,message}) -> alert message
    $.services.security.events.created.subscribe -> $.users.fetch()

    $.UserCollection = $.content.collection.extend model:$.user,url:"/content/detail/user"

    $.user = $.content.factory.create "/detail/user"
    $.users = new $.UserCollection()

  class this.Main
    constructor: (i) ->
      self = this

      this.login = ->
        console.log "name: "+self.name()
        console.log "pass: "+self.pass()
        $.services.security.authenticate name:self.name(),pass:self.pass()

      this.create = ->
        console.log "name: "+self.name()
        console.log "pass: "+self.pass()
        $.services.security.create name:self.name(),mail:self.name()+"@mail.com",pass:self.pass()

      this.name = ko.observable()
      this.pass = ko.observable()

      this.users = $.users

  $ ->
    ko.applyBindings new Main()
    $.users.fetch()

this.module =
  inline: [main]
  markup: []
  master:
    head: ->
      script type:"text/javascript",src:"/content?schema=1"
      script type:"text/javascript",src:"/socket-meta"

      title "My Title"

    body: ->
      div "navbar.navbar-inverse.navbar-fixed-top", ->
        div "navbar-inner", ->
          div "container", ->
            a "brand", href:"#", "Vertex"
            div "nav-collapse.collapse", ->
              ul "nav", ->
                li -> a href:"#", "Home"
                li -> a href:"#about", "About"
              div "navbar-form.pull-right", ->
                input type:"text",placeholder:"Username","data-bind":"value:name"
                input type:"password",placeholder:"Password","data-bind":"value:pass"
                button "btn","data-bind":"click:login","Sign In"
                button "btn","data-bind":"click:create","Register"
      div "&nbsp"
      div "#content.center", ->
        div "wrap","data-bind":"foreach:users", ->
          div ->
            label "Name:&nbsp"
            div "data-bind":"text:name"


