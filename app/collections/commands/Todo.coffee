class @CreateTodo extends Command

  execute: () ->
    @data.user = @user
    @insertEvent("TodoCreated", @data)

class @TodoCreated extends EventHandler
  execute: (data) ->
    id = Todos.insert(
      title: data.title
      user: data.user,
      completed: false
    )


Command.register("CreateTodo", @CreateTodo)
EventHandler.register("TodoCreated", @TodoCreated)


class @UpdateTodo extends Command

  allowed: () ->
    todo = Todos.findOne({key: @data.key})
    todo.user == @user

  execute: () ->
    if not @allowed()
      throw new Meteor.Error "command not allowed"
    @insertEvent("TodoUpdated", @data)

class @TodoUpdated extends EventHandler
  execute: (data) ->
    Todos.update({key: data.key}, $set: data.updates)


Command.register("UpdateTodo", @UpdateTodo)
EventHandler.register("TodoUpdated", @TodoUpdated)


class @TodoUpdatedPlus extends EventHandler
  execute: (data) ->
    TodoCount.update(todoCountId, $inc: {count: 1})

EventHandler.register("TodoUpdated", @TodoUpdatedPlus)

class @DeleteTodo extends Command

  allowed: () ->
    todo = Todos.findOne({key: @data.key})
    todo.user == @user
  execute: () ->
    if not @allowed()
      throw new Meteor.Error "command not allowed"
    @insertEvent("TodoDeleted", @data)

class @TodoDeleted extends EventHandler

  execute: (data) ->
    Todos.remove({key: data.key})
    [command.key]

Command.register("DeleteTodo", @DeleteTodo)
EventHandler.register("TodoDeleted", @TodoDeleted)