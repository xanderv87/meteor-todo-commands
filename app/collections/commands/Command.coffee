class @Command
  data: {}

  constructor: () ->
    if Meteor.isServer
      @user = this.userId
    else
      @user = Meteor.userId()
    @commandName = @.constructor.name

  executeClient: () ->
    console.log @

  insertEvent: (name, eventData) ->
    EventStore.insert
      executedAt: new Date
      name: name
      eventData: eventData
      executed: false



  execute: () ->
    if Meteor.isServer
      @execute()
    else
      @executeClient()


# static part

  @commands = {}

  @register = (name, command) ->
    @commands[name] = command

  @createCommand = (command) ->
    _.extend(new @commands[command.commandName](), command)

Meteor.methods(
  executeCommand: (command) ->
    c = Command.createCommand(command)
    c.execute()
)