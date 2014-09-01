@Threads = new Meteor.Collection('threads')

Threads.after.update (userId, doc, fieldNames, modifier, options)->

  Meteor.call 'updateUsersThreadsRec', userId, doc, fieldNames, modifier, options
