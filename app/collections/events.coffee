@EventStore = new Meteor.Collection 'events',
  schema: new SimpleSchema(
    executedAt:
      type: Date,
      label: 'Created At'

    name:
      type: String,
      label: 'Event Name'

    eventData:
      type: Object
      blackbox: true
      label: 'Event data'

    executed:
      type: Boolean,
      label: 'Already executed'

  )
@EventStore.allow(
  insert: (userId, doc) ->
    false
  update: (userId, doc, fields, modifier) ->
    false
  remove: (userId, doc) ->
    false
)

if Meteor.isServer

  execute = (id, fields) ->

    handlers = EventHandler.getEventHandlers fields.name

    _.each(handlers, (handler) ->
      (new handler()).execute(fields.eventData)
    )

    EventStore.update(id, $set: {executed: true})

  @EventStore.find({executed: false}, {limit: 1, sort: {executedAt: 1}}).observeChanges({
    added: execute
    changed: (id, fields) ->
      if fields.executed
        execute id, fields
  })