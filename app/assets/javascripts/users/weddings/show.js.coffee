$ ->
  $modal = $('#modal-from-dom').modal backdrop: true
  $('h3 a').bind 'click', (evt) ->
    evt.preventDefault()
    $.get this.href, (data) ->
      $modal.find('.modal-body').html(data)
      $modal.modal()

  $('*[rel=twipsy]').twipsy()
