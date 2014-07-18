@log = (el)->
  console.log(el)

#Meteor.call 'getLocale', (err, res)->
#  if err
#    log err
#  else
#    log res


Meteor.setLocale('ru')

Session.set 'mapLoaded', false

#Deps.autorun ->
#  if Meteor.user()
#    Router.go 'base'


Accounts.ui.config {
  requestPermissions: {
    facebook: ['user_likes', 'user_birthday', 'email', 'user_location', 'basic_info', 'user_checkins', 'user_hometown', 'user_interests', 'user_photos', 'user_relationships']
  }
}



UI.body.events {
  'click body': ->
    log 'yo'
}

UI.body.cloudfrontUrl = 'http://d1jfn2lab933y3.cloudfront.net/'




