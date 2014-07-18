Router.configure {
  notFoundTemplate: 'notFound'
  loadingTemplate: 'loading'
}

Router.map ->

  @route 'base', {
    path: '/'
#    waitOn: ->
#      Meteor.setTimeout ->
#        true
#      , 1000
#      Meteor.user()
#    onBeforeAction: ->
#      if !Meteor.loggingIn() and !Meteor.user()
#        @redirect 'hello'
    action: ->
      Meteor.setTimeout =>
        user = Meteor.user()
        if user
          console.log 'youLogged'
          status = user.profile.registration.status
          if status is 'tested'
            username = user.profile.username
            @redirect '/' + username
          else
            @redirect 'registration/hello'
  #        else if status is 'testing'
  #          @redirect 'registration/test'
        else
          @redirect 'hello'
      , 1000
  }

  @route 'hello', {
    layoutTemplate: 'hello'
  }

  @route 'registration', {
    layoutTemplate: 'registration'
    action: ->
      if !Meteor.user()
        Router.go 'base'
      else
#        @render()
  }

  @route 'registration/hello', {
    layoutTemplate: 'registration'
    waitOn: ->
      Meteor.subscribe('users')
    action: ->
      if !Meteor.user()
        Router.go 'base'
      else
        @render()
  }

#  @route 'registration/test', {
#    layoutTemplate: 'registration'
##    waitOn: ->
##      Meteor.subscribe('users')
#    data: ->
#      if Meteor.user()
#        step = Meteor.user().profile.registration.step
#        {
#          id: step
#          size: _.keys(Meteor.i18nMessages.registration.questions).length
#          question: __('registration.questions.' + step)
#          low: __('registration.questions.grades.low')
#          semilow: __('registration.questions.grades.semilow')
#          mid: __('registration.questions.grades.mid')
#          semihigh: __('registration.questions.grades.semihigh')
#          high: __('registration.questions.grades.high')
#        }
#    action: ->
#      if !Meteor.user()
#        @redirect 'base'
#      else
#        $('.reg-step').find('>div').removeClass '_active'
#        $('.reg-step').find('>div').eq(1).addClass '_active'
#        marginTop = 0 - $(window).height()
#        $('.registration').find('.info').css('margin-top', marginTop + 'px')
#        UI.insert UI.render(Template.testing_cont), $('#testing-insert').get(0)
#  }

  @route 'registration/finish', {
    template: 'testFinish'
    layoutTemplate: 'registration'
  }



  @route 'profile', {
    path: '/:username'
    layoutTemplate: 'mainLayout'
    template: 'profile'
    waitOn: Meteor.user()
    data: ->
      if Meteor.user()
        user = Meteor.users.findOne({'profile.username': @params.username})
        profile = user.profile
        {
          profile: profile
        }
    onBeforeAction: ->
      if !Meteor.user()
        Router.go 'base'
      else
        @render()
  }