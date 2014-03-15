class @CreateTodo extends Command
  constructor: (@title) ->
    @name = "CreateTodo"
    super

  execute: () ->
    Todos.insert(
      title: @title
      user: @user,
      completed: false
    )
    super

class @DeleteTodo extends Command
  constructor: (@id) ->
    @name = "DeleteTodo"
    super

  execute: () ->
    Todos.remove(@id)
    super

class @UpdateTodo extends Command
  constructor: (@id, @updates) ->
    @name = "UpdateTodo"
    super

  execute: () ->
    Todos.update(@id, $set: @updates)
    super