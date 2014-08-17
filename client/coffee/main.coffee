Session.set('usersLoaded', false)

@log = (el)->
  console.log(el)

#Meteor.call 'getLocale', (err, res)->
#  if err
#    log err
#  else
#    log res


Meteor.setLocale('ru')

Session.set 'mapLoaded', false

Deps.autorun ->
  if Meteor.user() and !Session.get('usersLoaded')
    log 'deps worked!'
    Session.set('usersLoaded', true)
    Router.go 'base'


Accounts.ui.config {
  requestPermissions: {
    facebook: ['user_likes', 'user_birthday', 'email', 'user_location', 'basic_info', 'user_checkins', 'user_hometown', 'user_interests', 'user_photos', 'user_relationships']
  }
}



#Init loader
Template.mainLayout.rendered = ->
  MainCtrl['loader'] = new CanvasLoader('main-loader')
  MainCtrl['loader'].setColor('#ffffff')
  MainCtrl['loader'].setDiameter(56)
  MainCtrl['loader'].setDensity(66)
  MainCtrl['loader'].setRange(1)
  MainCtrl['loader'].setFPS(51)
  console.log 'thid is main ctrl'
  console.log MainCtrl


UI.body.events {
  'click body': ->
    log 'yo'

}

UI.body.cloudfrontUrl = 'http://d1jfn2lab933y3.cloudfront.net/'




