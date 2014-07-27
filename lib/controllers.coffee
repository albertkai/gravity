if Meteor.isClient

  @MainCtrl = {
    showLoader: ->

      @loader.show()
      $('#main-loader').addClass('_visible')

    hideLoader: ->
      $('#main-loader').removeClass('_visible')
      Meteor.setTimeout =>
        @loader.hide()
      , 500
  }