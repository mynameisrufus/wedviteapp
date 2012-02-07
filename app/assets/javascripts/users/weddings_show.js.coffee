window.weddings = ->
  $modal = $('#modal-from-dom').modal('hide')
  $('h3 a').bind 'click', (evt) ->
    evt.preventDefault()
    $.get @href, (data) ->
      $modal.find('.modal-body').html(data)
      $modal.modal('show')

  $quickie = $('.quickie')

  $quickie.find('i[rel=popover]').popover placement: 'left'

  $quickie.find('.toggle').bind 'click', (evt) ->
    evt.preventDefault()
    $(@).toggleClass 'icon-white'
    id = $(@).data('id')
    $("##{id}").toggle()

  $quickie.find('.goto').bind 'click', (evt) ->
    evt.preventDefault()
    id = $(@).data('id')
    $('html, body').animate({scrollTop: ($("##{id}").offset().top - 50)}, 500)
