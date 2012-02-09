#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require twitter/bootstrap
#= require users/locations_form
#= require users/weddings_show

class window.GuestList
  constructor: ->
    $('.guest-container .row.guest.actions').hide()
    $('.guest-container .row.guest.comments').hide()
    $('.guest-container').each (index, el) ->
      $(el).find('.row.guest.headline .btn.show-actions').bind 'click', ->
        div = $(el).find('.row.guest.actions')
        if div.is(':visible')
          $(this).html('Show actions')
          div.hide()
        else
          $(this).html('Hide actions')
          div.show()
      $(el).find('.row.guest.headline .btn.comments').bind 'click', ->
        div = $(el).find('.row.guest.comments')
        if div.is(':visible')
          $(this).html("Show comments (#{$(div).find('.comment').length})")
          div.hide()
        else
          $(this).html('Hide comments')
          div.show()

class window.WeddingForm
  constructor: ->
    $("#wedding_has_reception").bind 'click', (evt) ->
      if $(this).is(':checked')
        $("#reception").fadeIn()
      else
        $("#reception").fadeOut()

$ ->
  $("#menu").dropdown()
