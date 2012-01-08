#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require_tree .

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
