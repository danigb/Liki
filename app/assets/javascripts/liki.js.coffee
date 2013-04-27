$(document). on 'click', 'a[data-action=add_children]', ->
  $('div.add_children').show()
  false

mentions = /@([^\s^:^.^,^<^"^)^(]+)/g
hashtag = /#([^\s^:^.^,^<^"^(^)]+)/g
linkify = ->
  $('.body').each ->
    html = $(this).html()
    html = html.replace hashtag, replacer
    html = html.replace mentions, replacer
    $(this).html(html)

replacer = (name) ->
  name = name[1..-1]
  url = toUrl(name)
  "<a class='linkify' href='/p/#{url}'>#{name}</a>"

toUrl = (name) ->
  name.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase()

$(document).ready linkify
$(window).bind 'page:load', linkify
