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

    notify: (title, text, type, icon)->

      notifyObject = do ->
        if title and !type and !text and !icon
          {
            text: title
          }
        else if title and text and !type and !icon
          {
            title: title
            text: text
          }
        else if title and text and type and !icon
          {
            title: title
            text: text
            type: type
          }

        else
          {
            title: title
            text: text
            type: type
            icon: icon
          }

      new PNotify notifyObject
  }