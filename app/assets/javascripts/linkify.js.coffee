hashtag = /(?:\s|>)#([^\s^:^.^,^<^"^(^)]+)/g
linkify = ->
  $('.hashtags').each ->
    html = $(this).html()
    console.log "HTML #{html}"
    html = html.replace /\&nbsp;/g, ' '
    html = html.replace hashtag, replacer
    $(this).html(html)

replacer = (string) ->
  index = string.indexOf('#')
  name = string[index + 1..-1]
  prefix = string[0..index - 1]
  url = toUrl(name)
  "#{prefix}<a class='linkify' href='/p/#{url}'>#{name}</a>"

toUrl = (name) ->
  removeDiacritics(name.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase())

$(document).ready linkify
$(window).bind 'page:load', linkify

