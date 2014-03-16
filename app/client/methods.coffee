@executeCommand = (command) ->
  Meteor.call('executeCommand', command, (error, result) ->
    if error
      console.log error
  )

Meteor.methods(
  executeCommand: (command) ->
    console.log command
)