class @Command
  constructor: () ->
    @user = Meteor.userId()

  execute: () ->
    console.log @
    EventStore.insert(
      executedAt: new Date
      command: @
    )

Command.createCommand = (command) ->
  switch command.name
    when "CreateTodo"
      new CreateTodo(command.title)
    when "DeleteTodo"
      new DeleteTodo(command.id)
    when "UpdateTodo"
      new UpdateTodo(command.id, command.updates)