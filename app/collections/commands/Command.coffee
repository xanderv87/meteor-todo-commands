class @Command
  constructor: () ->
    @user = Meteor.userId()
  allowed: () ->
    true
  _execute: () ->
    EventStore.insert(
      executedAt: new Date
      command: @
    )


  execute: () ->
    if @allowed()
      @_execute()
    else
      throw new Meteor.Error("command is not allowed")

  @commands = {}

  @registerCommand = (name, command) ->
    @commands[name] = command

  @createCommand = (command) ->
    _.extend(new @commands[command.name](), command)
