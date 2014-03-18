@Todos = new Meteor.Collection 'todos',
  schema: new SimpleSchema(
    key:
      type: Number
      index: 1
      autoValue: () ->
        if @isInsert
          incrementCounter('todos')

    title:
      type: String,
      label: 'Title',
      max: 200
    user:
      type: String,
      label: 'Created by'
    completed:
      type: Boolean
      label: 'Completed'
  )


@Todos.allow(
  insert: (userId, doc) ->
    false
  update: (userId, doc, fields, modifier) ->
    false
  remove: (userId, doc) ->
    false
)


@TodoCount = new Meteor.Collection 'todoCount'
@todoCountId = ""
if Meteor.isServer
  @todoCountId = @TodoCount.insert({count: 0})