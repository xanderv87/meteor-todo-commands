Template.home.rendered = ->

  #SEO Page Title & Description
  document.title = "My New Meteor App"
  $(
    "<meta>",
    {
      name: "description",
      content: "Page description for My New Meteor App"
    }).appendTo "head"

Template.home.todos = ->
  Todos.find()

Template.home.eventList = ->
  EventStore.find({}, {sort: {executedAt: -1}})

Template.todo.todo_editing = ->
  Session.equals 'editing_todo', this._id

Template.home.events =
  'click button.create': ->
    c = new CreateTodo()
    c.data =
      title: $("#new-todo").val()
    console.log c
    executeCommand(c)

Template.todo.events =
  'click button.destroy': ->
    c = new DeleteTodo()
    c.data =
      id: @_id
    executeCommand(c)
  'click i.fa': (e) ->
    c = new UpdateTodo()
    c.data =
      id: @_id
      updates: {completed: !this.completed}
    executeCommand(c)

Template.event.stringify = ->
  JSON.stringify @data