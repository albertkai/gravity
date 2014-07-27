Router.configure {
  notFoundTemplate: 'notFound'
  loadingTemplate: 'loading'
}

Router.map ->

  @route 'base', {
    path: '/'
    waitOn: ->
      Meteor.subscribe('users')
    onBeforeAction: ->
      if !Meteor.loggingIn() and !Meteor.user()
        @redirect 'hello'
    action: ->
      if Meteor.user()
        user = Meteor.user()
        console.log 'youLogged'
        status = user.profile.registration.status
        if status is 'tested'
          log 'redirecting to username from base route'
          username = user.profile.username
          @redirect '/' + username
        else
          log 'redirecting to registration/hello from base route'
          @redirect 'registration/hello'
      else
        @redirect 'hello'
  }

  @route 'hello', {
    layoutTemplate: 'hello'
    onBeforeAction: ->
      if Meteor.user()
        @redirect '/'
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
    layoutTemplate: 'registrationLayout'
    template: 'registration'
    waitOn: ->
      Meteor.subscribe('users')
    action: ->
      if !Meteor.user()
        log 'redirecting to base'
        Router.go 'base'
      else
        log Meteor.user()
        @render()
#        log 'registration/hello, found user'
#        status = Meteor.user().profile.registration.status
#        if status is "justRegistered"
#          log 'router is rendering info template from action'
#          UI.insert UI.render(Template.info), $('#info-insert').get(0)
#        else if status is "testing"
#          log 'router is rendering testing template from action'
#          $('.reg-step').find('>div').removeClass '_active'
#          $('.reg-step').find('>div').eq(1).addClass '_active'
#          marginTop = 0 - $(window).height()
#          $('.registration').find('.info').css('margin-top', marginTop + 'px')
#          UI.insert UI.render(Template.testing_cont), $('#testing-insert').get(0)
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