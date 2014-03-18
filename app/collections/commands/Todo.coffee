class @CreateTodo extends Command
  constructor: () ->
    @name = "CreateTodo"
    super


  _execute: () ->
    Todos.insert(
      title: @title
      user: @user,
      completed: false
    )
    super
Command.registerCommand("CreateTodo", @CreateTodo)

class @UpdateTodo extends Command
  constructor: () ->
    @name = "UpdateTodo"
    super
  allowed: () ->
    todo = Todos.findOne(@id)
    todo.user == @user
  _execute: () ->
    Todos.update(@id, $set: @updates)
    super

Command.registerCommand("UpdateTodo", @UpdateTodo)

class @DeleteTodo extends Command
  constructor: () ->
    @name = "DeleteTodo"
    super
  allowed: () ->
    todo = Todos.findOne(@id)
    todo.user == @user
  _execute: () ->
    Todos.remove(@id)
    super
Command.registerCommand("DeleteTodo", @DeleteTodo)