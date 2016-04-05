//= require jquery
//= require tether
//= require bootstrap
//= require_tree .

// TODO remove me on redesign of UI
//= require ../lib/jquery.slide-deck


(function() {
  window.GuestList = (function() {
    function GuestList() {
      $('.guest-container .row.guest.actions').hide();
      $('.guest-container .row.guest.comments').hide();
      $('.guest-container').each(function(index, el) {
        $(el).find('.row.guest.headline .btn.show-actions').bind('click', function() {
          var div;
          div = $(el).find('.row.guest.actions');
          if (div.is(':visible')) {
            $(this).html('Show actions');
            return div.hide();
          } else {
            $(this).html('Hide actions');
            return div.show();
          }
        });
        return $(el).find('.row.guest.headline .btn.comments').bind('click', function() {
          var div;
          div = $(el).find('.row.guest.comments');
          if (div.is(':visible')) {
            $(this).html("Show comments (" + ($(div).find('.comment').length) + ")");
            return div.hide();
          } else {
            $(this).html('Hide comments');
            return div.show();
          }
        });
      });
    }

    return GuestList;

  })();

  $(function() {
    return $("#menu").dropdown();
  });

}).call(this);
