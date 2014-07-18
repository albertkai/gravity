Template.profileMainInfo.helpers {

  working: ->
    {
    personality: __('profile.mainInfo.personality')
    ideology: __('profile.mainInfo.ideology')
    recomendations: __('profile.mainInfo.recomendations')
    }
}

Template.profile.rendered = ->
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



profileCtrl = {

  buildCosmogram: (data)->
    paper = new Raphael('cosmogramm', 350, 350)
    paper.circle(170, 170, 132).attr({"stroke-width": 2, stroke: '#00ff00', "fill-opacity": .4})
    paper.circle(170, 170, 120).attr({"stroke-width": 0, stroke: '#00ff00', "fill": "#8855cc", "fill-opacity": 1})
    paper.circle(170, 170, 70).attr({"stroke-width": 0, stroke: '#00ff00', "fill": "#ffffff", "fill-opacity": 1})
    paper.circle(170, 38, 14).attr({fill: "#fff", transform: "r" + (- data.sun.longitude - 90) +  " 170 170", "fill-opacity": 1})
    paper.circle(170, 38, 10).attr({fill: "#fff", transform: "r" + (- data.moon.longitude - 90) +  " 170 170", "fill-opacity": 1})
    paper.circle(170, 38, 9).attr({fill: "#fff", transform: "r" + (- data.houses.ascendant - 90) +  " 170 170", "fill-opacity": 1})
    for i in [0..360] by 30
      paper.path("M170 170l0 130").attr({"stroke": "white", "stroke-width": 1, transform: "r" + i + " 170 170", "stroke-opacity": .4})


  getDesc: (data)->

}