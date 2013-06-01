$(document). on 'click', 'a[data-toggle]', ->
  css_class = $(this).data('toggle')
  $("div.#{css_class}").toggle()
  $(this).hide()
  false

init = ->
  image = $('body').data('backimage')
  $('html').css('background-image', "url(#{image})")
  $("#node_body").each ->
    console.log 'Editamos'
    new wysihtml5.Editor "node_body",
      toolbar:      "wysihtml5-toolbar"
      #parserRules:  wysihtml5ParserRules,
      parserRules: { tags: { br: {}, span: {}, div: {}, p: {}, ol: {}, li: {}, h4: {} }, classes: {} }
      useLineBreaks: false
 

$(document).ready init
$(window).bind 'page:load', init


