create_map = ->
  ww = $(window).width()
  wh = $(window).height()
  $('#springy').attr('width', ww - 160).attr('height', wh - 160)
  graph = new Springy.Graph()
  json = $.parseJSON($('#map-data').text())
  $('#map-data').hide()
  graph.loadJSON(json);

  $('#springy').springy { graph: graph }

$(document).ready create_map
$(window).bind 'page:load', create_map

