@utils = {

  bgImageLoaded: ($el, callback)->
    MainCtrl.showLoader()
    src = $el.css('background-image').replace(/"/g, '').replace(/url\(|\)$/ig, '')
    image = $('<img>').attr('src', src)
    console.log image
#    image.load ->
#      callback()
#      MainCtrl.hideLoader()
    callback()
    MainCtrl.hideLoader()

}


#Utils sessions
Session.set('registration.slidesTriggeredByRoute', true)
