$(document). on 'click', 'a[data-toggle]', ->
  css_class = $(this).data('toggle')
  $("div.#{css_class}").toggle()
  $(this).toggleClass('active')
  false

init = ->
  image = $('body').data('backimage')
  $('html').css('background-image', "url(#{image})")
  #$.backstretch(background)


$(document).ready init
$(window).bind 'page:load', init


