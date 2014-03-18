class @EventHandler
  constructor: () ->
    if Meteor.isServer
      this.userId
    else
      @user = Meteor.userId()
    @eventName = @.constructor.name



  @eventHandlers: {}
  @register: (commandName, eventHandler) ->
    if not @eventHandlers[commandName]
      @eventHandlers[commandName] = []
    @eventHandlers[commandName].push(eventHandler)

  @getEventHandlers: (commandName) ->
    @eventHandlers[commandName] or []


