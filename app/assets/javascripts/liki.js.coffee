$(document). on 'click', 'a[data-toggle]', ->
  css_class = $(this).data('toggle')
  $("div.#{css_class}").show()
  $(this).hide()
  false

mentions = /\s@([^\s^:^.^,^<^"^)^(]+)/g
hashtag = /\s#([^\s^:^.^,^<^"^(^)]+)/g
linkify = ->
  $('.body').each ->
    html = $(this).html()
    html = html.replace hashtag, replacer
    html = html.replace mentions, replacer
    $(this).html(html)

replacer = (name) ->
  name = name[2..-1]
  url = toUrl(name)
  "&nbsp;<a class='linkify' href='/p/#{url}'>#{name}</a>"

toUrl = (name) ->
  name.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase()

$(document).ready linkify
$(window).bind 'page:load', linkify
