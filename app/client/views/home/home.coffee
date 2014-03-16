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
    c.title = $("#new-todo").val()
    executeCommand(c)

Template.todo.events =
  'click button.destroy': ->
    c = new DeleteTodo()
    c.id= @_id
    executeCommand(c)
  'change input[type=checkbox]': (e) ->
    c = new UpdateTodo()
    c.id = @_id
    c.updates = {completed: $(e.currentTarget)[0].checked}
    executeCommand(c)

Template.event.stringify = ->
  JSON.stringify @command