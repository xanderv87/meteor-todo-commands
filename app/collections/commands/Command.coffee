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

Command.commands = {}
Command.registerCommand = (name, command) ->
  @commands[name] = command
Command.createCommand = (command) ->
    _.extend(new @commands[command.name](), command)
