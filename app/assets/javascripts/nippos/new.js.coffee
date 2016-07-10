$ ->
  $('.form-group.date-noticing').each ->
    fg = $(@)
    input = fg.find('input')
    notice = fg.find('.date-notice')

    input.on 'change', ->
      notice.hide()
