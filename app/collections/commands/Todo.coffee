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
    [id]


Command.register("CreateTodo", @CreateTodo)
EventHandler.register("TodoCreated", @TodoCreated)


class @UpdateTodo extends Command

  allowed: () ->
    todo = Todos.findOne(@data.id)
    todo.user == @user

  execute: () ->
    if not @allowed()
      throw new Meteor.Error "command not allowed"
    @insertEvent("TodoUpdated", @data)

class @TodoUpdated extends EventHandler
  execute: (data) ->
    Todos.update(data.id, $set: data.updates)
    [@id]

Command.register("UpdateTodo", @UpdateTodo)
EventHandler.register("TodoUpdated", @TodoUpdated)


class @TodoUpdatedPlus extends EventHandler
  execute: (data) ->
    console.log "TodoUpdatedPlus"
    console.log todoCountId
    TodoCount.update(todoCountId, $inc: {count: 1})
    console.log TodoCount.findOne(todoCountId)

EventHandler.register("TodoUpdated", @TodoUpdatedPlus)

class @DeleteTodo extends Command

  allowed: () ->
    todo = Todos.findOne(@data.id)
    todo.user == @user
  execute: () ->
    if not @allowed()
      throw new Meteor.Error "command not allowed"
    @insertEvent("TodoDeleted", @data)

class @TodoDeleted extends EventHandler

  execute: (command) ->
    Todos.remove(command.id)
    [command.id]

Command.register("DeleteTodo", @DeleteTodo)
EventHandler.register("TodoDeleted", @TodoDeleted)