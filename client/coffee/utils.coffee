@utils = {
  bgImageLoaded: ($el, callback)->
    src = $el.css('background-image').replace(/"/g, '').replace(/url\(|\)$/ig, '')
    image = $('<img>').attr('src', src)
    console.log image
    image.load ->
      callback()
}


#Utils sessions
Session.set('registration.slidesTriggeredByRoute', true)
