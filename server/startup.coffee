Meteor.startup ->
  @i18n = Meteor.require 'i18n'
  @path = Npm.require('path')
  @swisseph = Meteor.require 'swisseph'



#  i18n.configure({
#    locales: ['ru', 'en', 'de'],
#    directory: path.__dirname + '/locales'
#  })