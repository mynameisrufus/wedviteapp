window.weddings = ->
  $modal = $('#modal-from-dom').modal('hide')
  $('h3 a').bind 'click', (evt) ->
    evt.preventDefault()
    $.get @href, (data) ->
      $modal.find('.modal-body').html(data)
      $modal.modal('show')

  $( ".guests .column" ).each (index, col) ->
    $(col).sortable
      placeholder: "guest-placeholder"
      axis: 'y'
      update: (event, ui) ->
        $.ajax
          type: 'POST'
          dataType: 'json'
          data:
            index: ui.item.index()
          url: "#{window.location.pathname}/guests/#{ui.item.data('id')}/move"

  $( ".guests .column" ).disableSelection()

  $quickie = $('.quickie')
  $quickie.find("*[rel=tooltip]").tooltip delay: { show: 500, hide: 100 }

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
