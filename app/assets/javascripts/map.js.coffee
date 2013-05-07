create_map = ->
  if $('#map-data').length > 0
    ww = $(window).width()
    wh = $(window).height()
    $('#springy').attr('width', ww - 160).attr('height', wh - 160)
    graph = new Springy.Graph()
    json = $.parseJSON($('#map-data').text())
    graph.loadJSON(json)
    $('#map-data').hide()

    $('#springy').springy { graph: graph }

$(document).ready create_map
$(window).bind 'page:load', create_map

