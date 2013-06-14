$(document). on 'click', 'a[data-toggle]', ->
  css_class = $(this).data('toggle')
  $("div.#{css_class}").toggle()
  $(this).hide()
  false

tags = 
  br: 1
  span: 1
  div: 1
  p: 1
  ol: 1
  ul: 1
  li: 1
  h4: 1
  blockquote: 1
  underline: 1
  i: 1
  b: 1
  strong: { rename_tag: 'b' }
  a:
    check_attributes:
      href: 'url'
    set_attributes:
      rel: 'nofollow'
      target: '_blank'


init = ->
  image = $('body').data('backimage')
  $('html').css('background-image', "url(#{image})")
  $("#node_body").each ->
    console.log 'Editamos'
    new wysihtml5.Editor "node_body",
      toolbar:      "wysihtml5-toolbar"
      #parserRules:  wysihtml5ParserRules,
      parserRules: { tags: tags, classes: {} }
      useLineBreaks: true
 

$(document).ready init
$(window).bind 'page:load', init

$(window).bind 'page:load', ->
  if $('.gmaps4rails_map').length > 0
    Gmaps.loadMaps()

