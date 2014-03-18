Template.home.rendered = ->

  #SEO Page Title & Description
  document.title = "Todo Commands"
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
    executeCommand(c)

Template.todo.events =
  'click button.destroy': ->
    c = new DeleteTodo()
    c.data =
      key: @key
    executeCommand(c)
  'click i.fa': (e) ->
    c = new UpdateTodo()
    c.data =
      key: @key
      updates: {completed: !this.completed}
    executeCommand(c)

Template.event.stringify = ->
  JSON.stringify @eventData