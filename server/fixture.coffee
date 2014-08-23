#if Meteor.users.find().count() > 0
#  Meteor.users.find().fetch().forEach (user)->
#    id = user._id
#    Meteor.users.remove id

#Meteor.users.update "rf4pFXbkTJT5YKaGu", {$set: {'profile.customize.backgroundPic': 'images/sample_shanghai.jpg'}}
##Meteor.users.update "esLjvkvo7uCgGzATQ", {$set: {'profile.registration.step': 60}}
#
#user = Accounts.createUser {
#  username: 'albertkai',
#  email: 'albertkai@me.com',
#  password: '56114144as',
#  profile: {
#    name: 'Альберт',
#    surname: 'Кайгородов'
#    city: 'Saint-Petersburg',
#    country: 'Russia'
#  }
#}

#Roles.addUsersToRoles(user, ['user'])
