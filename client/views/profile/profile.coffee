Template.profileMainInfo.helpers {

  working: ->
    {
    personality: __('profile.mainInfo.personality')
    ideology: __('profile.mainInfo.ideology')
    recomendations: __('profile.mainInfo.recomendations')
    }
}



Template.profileMainInfo.rendered = ->

  log 'profileMainInfo template rendered!'
  profileCtrl.tabs.init()
  profileCtrl.stickyMenu.init()

  $('.info-tabs').waypoint (dir)->
    if $('#personality').hasClass '_active'
      if dir is 'up'
        profileCtrl.stickyMenu.noStick()
      else if dir is 'down'
        profileCtrl.stickyMenu.stick()

  $('.context-nav.sticky ul li').waypoint ->
    $('.context-nav.sticky ul li').removeClass '_active'
    $(this).addClass '_active'


Template.profileMainInfo.events {

  'click .top-menu ul li': (e)->

    index = $(e.currentTarget).index()
    profileCtrl.tabs.goTo index

    $('.top-menu ul li').removeClass '_active'
    $(e.currentTarget).addClass '_active'

  'click .context-nav.sticky ul li': (e)->

    target = $(e.currentTarget).data('target')
    $.scrollTo $('#' + target), 800

}



Template.profile.rendered = ->

  log 'Profile template rendered!'
  $('body').sexyMenu()
  $('.top').attr('data-stellar-background-ratio', .6)
  log 'heeey'
  log @data
  $.stellar()
  words = [
    {text: 'веселый', weight: 22},
    {text: 'добрый', weight: 21},
    {text: 'отзывчивый', weight: 20},
    {text: 'творческий', weight: 19},
    {text: 'артистичный', weight: 18},
    {text: 'флегматичный', weight: 17},
    {text: 'новаторский', weight: 16},
    {text: 'непосредственный', weight: 15}
  ]
  $("#tag-cloud").jQCloud(words)
  date = {}
  date['year'] = 1989
  date['month'] = 1
  date['day'] = 4
  date['hour'] = 0
  date['timezone'] = 7
  lat = 53
  lng = 83
  Meteor.call 'getAstroData', date, lat, lng, (err, data)->
    if err
      console.log err
    else
      console.log data
      profileCtrl.buildCosmogram(data)
  profileCtrl.buildJohari()


Template.johariOutput.rendered = ->

  id = $('#userId').val()
  data = Meteor.users.findOne(id).profile.tests.johari
  profileCtrl.buildJohari(data)

Template.bigFiveOutput.rendered = ->

  id = $('#userId').val()
  data = Meteor.users.findOne(id).profile.tests.bigFive.results
  profileCtrl.buildBigFive(data)




@profileCtrl = {

  buildCosmogram: (data)->

    paper = new Raphael('cosmogramm', 350, 350)
    paper.circle(170, 170, 150).attr({"stroke-width": 0, stroke: '#00ff00', "fill": "#8ef1fc", "fill-opacity": 1})
    paper.circle(170, 170, 117).attr({"stroke-width": 0, stroke: '#00ff00', "fill": "#ffffff", "fill-opacity": 1})
    paper.circle(170, 170, 100).attr({"stroke-width": 1, stroke: '#8ef1fc', "opacity": .7})

    paper.circle(170, 71, 14).attr({fill: "#00ff00", "stroke-width": 0, transform: "r" + (- data.sun.longitude - 90) +  " 170 170", "fill-opacity": 1})
    paper.circle(170, 71, 14).attr({fill: "#64ffc6", "stroke-width": 0, transform: "r" + (- data.moon.longitude - 90) +  " 170 170", "fill-opacity": 1})
    paper.circle(170, 71, 14).attr({fill: "#ffc0f8", "stroke-width": 0, transform: "r" + (- data.houses.ascendant - 90) +  " 170 170", "fill-opacity": 1})
    for i in [0..360] by 30
      paper.path("M170 170l0 150").attr({"stroke": "white", "stroke-width": 1, transform: "r" + i + " 170 170", "stroke-opacity": .6})


  buildBigFive: (data)->

    colors = {
      1:
        sat: '#ff579e'
        light: '#ffc1db'
      2:
        sat: '#ff5cb8'
        light: '#ffc1e4'
      3:
        sat: '#ff6ad7'
        light: '#ffbded'
      4:
        sat: '#f564ff'
        light: '#fbbfff'
      5:
        sat: '#e56aff'
        light: '#f4c1ff'
      6:
        sat: '#c662ff'
        light: '#e5b8ff'
      7:
        sat: '#b46aff'
        light: '#dfc0ff'
      8:
        sat: '#9e6fff'
        light: '#d4bfff'
      9:
        sat: '#8672ff'
        light: '#c9c0ff'
      10:
        sat: '#6990ff'
        light: '#bbcdff'
      11:
        sat: '#66b9ff'
        light: '#bde1ff'
      12:
        sat: '#5dc8ff'
        light: '#bbe8ff'
      13:
        sat: '#4adbff'
        light: '#b2f0ff'
      14:
        sat: '#33e5ff'
        light: '#a9f4ff'
      15:
        sat: '#2dfffd'
        light: '#a5fffe'
      16:
        sat: '#3bffd8'
        light: '#b3fff0'
      17:
        sat: '#38ffad'
        light: '#b9ffe2'
      18:
        sat: '#3dff81'
        light: '#bdffd4'
      19:
        sat: '#55ff4d'
        light: '#beffbb'
      20:
        sat: '#89ff60'
        light: '#d2ffc2'
      21:
        sat: '#a4ff4c'
        light: '#deffbe'
      22:
        sat: '#c1ff48'
        light: '#e8ffbd'
      23:
        sat: '#d0ff2b'
        light: '#f0ffbd'
      24:
        sat: '#e8ff24'
        light: '#f7ffb4'
      25:
        sat: '#fcff27'
        light: '#feffab'
    }

    #Creating canvases

    primary = new Raphael('primary-output', 680, 180)
    secondary = new Raphael('secondary-output', 630, 380)

    #Primary graph

    primary.text(160, 10, '-100')
    primary.text(202, 10, '-75')
    primary.text(244, 10, '-50')
    primary.text(286, 10, '-25')
    primary.text(328, 10, '0')
    primary.text(370, 10, '25')
    primary.text(412, 10, '50')
    primary.text(454, 10, '75')
    primary.text(496, 10, '100')

    max = 188

    lineColor = '#ddd'
    primary.path('M160 25 l0 130').attr('stroke': lineColor, 'stroke-width': 1)
    primary.path('M202 25 l0 130').attr('stroke': lineColor, 'stroke-width': 1)
    primary.path('M244 25 l0 130').attr('stroke': lineColor, 'stroke-width': 1)
    primary.path('M286 25 l0 130').attr('stroke': lineColor, 'stroke-width': 1)
    primary.path('M328 18 l0 144').attr('stroke': lineColor, 'stroke-width': 1)
    primary.path('M370 25 l0 130').attr('stroke': lineColor, 'stroke-width': 1)
    primary.path('M412 25 l0 130').attr('stroke': lineColor, 'stroke-width': 1)
    primary.path('M454 25 l0 130').attr('stroke': lineColor, 'stroke-width': 1)
    primary.path('M496 25 l0 130').attr('stroke': lineColor, 'stroke-width': 1)


    primary.text(30, 50, 'интраверсия')
    primary.text(560, 50, 'экстраверсия')

    i = 0
    for level of data.primary
      if data.primary[answer] > 50
        width = (data.primary[answer] - 50) * 2

    #Secondary graph
    i = 0
    for answer of data.secondary
      x = i * 25
      height = data.secondary[answer] * 200
      y = 200 - height
      width = 21

      secondary.rect(x, y, width, height).attr({'fill': colors[i + 1].sat, 'stroke-width': 0})

      text = __('profile.bigFive.' + answer)
      secondary.text(x, 210, text).attr({transform: 'r-90', 'font-size': '12px', color: colors[i + 1].sat})

      percentage = parseInt data.secondary[answer] * 100, 10
      secondary.text(x + 10, y - 10, percentage + '%')

      i++


  buildJohari: (data)->

    open = [
      {text: 'веселый', weight: 22},
      {text: 'добрый', weight: 21},
      {text: 'отзывчивый', weight: 20},
    ]
    blind = [
      {text: 'умный', weight: 22},
      {text: 'интересный', weight: 21},
      {text: 'лояльный', weight: 20},
    ]
    hidden = [
      {text: 'отважный', weight: 22},
      {text: 'стабильный', weight: 21},
      {text: 'интересный', weight: 20},
    ]
    unknown = ['интровертный, энергичный, добрый, отзывчивый, знаменательный, смелый, дружелюьный, достойный, автократичный, упрямый, религиозный, спонтанный, новаторский, традиционный']

    $('#open-sector').jQCloud(open)
    $('#blind-sector').jQCloud(blind)
    $('#hidden-sector').jQCloud(hidden)

    unknownMarkup = ''
    for trait in unknown
      unknownMarkup += trait + ', '

    $('#unknown-sector').html unknownMarkup


  getDesc: (data)->
    #

  tabs: {

    init: ->

      #Initializing elements
      log 'initializing tabs'
      @cont = $('.info-tabs')
      @wrap = @cont.find('.info-tabs-cont')
      @tab = @cont.find('.info-cont')

      @tab.first().addClass '_active'

      @setSizes()
      @handleResize()

    handleResize: ->

      $(window).resize =>

        debouncedFunc = _.debounce =>
          @setSizes()
        , 500

        debouncedFunc()

    setSizes: ->

      log 'Set sizes'
      width = $(window).width()
      @wrap.css('width', width * 3 + 10 + 'px')
      @tab.css('width', width + 'px')

      left = @wrap.find('.info-cont._active').index() * $(window).width() * -1
      @wrap.css('left', left + 'px')

    goTo: (index)->

      width = $(window).width()
      contWidth = width * index * -1
      @wrap.css('left', contWidth + 'px')

      @tab.removeClass '_active'
      @tab.eq(index).addClass '_active'

  }

  stickyMenu: {

    init: ->

      @menu = $('.context-nav.sticky')
      width = @menu.width()
      @menu.css('width', width + 'px')
      @handleResize()

    setOffsets: ->

      @menu.css('left', left + 'px')
      @menu.css('top', '100px')

    handleResize: ->

      debouncedFunc = _.debounce =>
        @stick()
        log 'debounced resize'
      , 500

      $(window).resize =>

        if @menu.hasClass '_sticked'

          debouncedFunc()

    stick: ->

      left = ($(window).width() - $('.container').width()) / 2
      @menu.css('left', left + 'px')
      @menu.css('top', '22px')
      @menu.addClass '_sticked'

    noStick: ->

      @menu.removeClass '_sticked'

  }

}