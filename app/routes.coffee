Router.map ->
  @route 'home',
    path: '/'

  @route 'dashboard',
    path: '/dashboard'
    before: ->
      AccountsEntry.signInRequired(@)

  @route 'notFound',
    path: '*'
    where: 'server'
    action: ->
      @response.statusCode = 404
      @response.end Handlebars.templates['404']()
