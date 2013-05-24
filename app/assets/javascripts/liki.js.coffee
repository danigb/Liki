$(document). on 'click', 'a[data-toggle]', ->
  css_class = $(this).data('toggle')
  $("div.#{css_class}").show()
  $(this).hide()
  false

init = ->
  background  = $('body').data('backimage')
  $.backstretch(background)


$(document).ready init
$(window).bind 'page:load', init


