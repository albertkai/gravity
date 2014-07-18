if Meteor.users.find().count() > 0
  Meteor.users.find().fetch().forEach (user)->
    id = user._id
    Meteor.users.remove id

#  user = Accounts.createUser {
#    username: 'albertkai'
#    email: 'albertkai@me.com'
#    password: '56114144as'
#    profile: {
#      name: 'Альберт',
#      surname: 'Кайгородов'
#      city: 'Saint-Petersburg',
#      country: 'Russia'
#    }
#  }

#  Roles.addUsersToRoles(user, ['user'])