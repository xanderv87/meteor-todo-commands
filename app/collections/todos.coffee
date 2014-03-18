@Todos = new Meteor.Collection 'todos',
  schema: new SimpleSchema(
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


@TodoCount = new Meteor.Collection null

@todoCountId = @TodoCount.insert({count: 0})