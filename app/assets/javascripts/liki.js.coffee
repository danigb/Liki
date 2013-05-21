$(document). on 'click', 'a[data-toggle]', ->
  css_class = $(this).data('toggle')
  $("div.#{css_class}").show()
  $(this).hide()
  false

