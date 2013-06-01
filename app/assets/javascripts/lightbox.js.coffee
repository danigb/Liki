lightbox = ->
  $('img.lightbox').click  ->
    src = $(this).attr('src')
    $("div#lightbox a").html("<img src='#{src}' />")
    $("div#lightbox").addClass('active')

  $('#lightbox a').click -> $("div#lightbox").removeClass('active')

$(document).ready lightbox
$(window).bind 'page:load', lightbox
