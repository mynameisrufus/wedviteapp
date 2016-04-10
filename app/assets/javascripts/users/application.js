//= require jquery
//= require jquery_ujs
//= require tether
//= require bootstrap
//= require medium-editor
//= require to-markdown
//= require_tree .

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
    $("#menu").dropdown();

    var $modal = $('#modal-from-dom')

    $('a.modal-me').on('click', function(event) {
        event.preventDefault()
        $.get(this.href, function(data) {
            $modal.html(data).modal('show')
        })
    })

    // Guest list
    $('.bride-groom').each(function(index, elem) {
      var $edit = $(elem).find('a')
      $edit.on('click', function(event) {
        event.preventDefault()
        $(elem).find('.details').hide()
        $(elem).find('form').show()
      })
    })

    $quickie = $('.quickie')
    $quickie.find("*[rel=tooltip]").tooltip({delay: { show: 1000, hide: 100 }})

    $quickie.find('.toggle').on('click', function(event) {
      event.preventDefault()
      $(this).toggleClass('icon-eye').toggleClass('icon-eye-close')
      var id = $(this).data('id')
      $("#" + id).toggle()
    })

    $quickie.find('.goto').on('click', function(event) {
      event.preventDefault()
      var id = $(this).data('id')
      console.log(id);
      $('html, body').animate({scrollTop: ($("#" + id).offset().top - 50)}, 500)
    })

    function getScrollTop(){
        if(typeof pageYOffset!= 'undefined'){
            //most browsers
            return pageYOffset;
        }
        else{
            var B= document.body; //IE 'quirks'
            var D= document.documentElement; //IE with doctype
            D= (D.clientHeight)? D: B;
            return D.scrollTop;
        }
    }

    var $topButton = $('.goto-top')
    var $wrapper = $('.quickie .wrapper')

    $topButton.hide()
    $wrapper.css('position', 'absolute')

    $(window).on('scroll', function(){
        if (getScrollTop() > 185) {
            $topButton.show()
            $wrapper.css({position: 'fixed', top: 30})
        } else {
            $topButton.hide()
            $wrapper.css({position: 'absolute', top: 0})
        }
    })

    var $guests = $('.guests .guest')
    var showGuestActions = function(event) {
        el = this
        $guests.each(function(index, elem) {
            if(el != elem) $(elem).removeClass('active')
        })
        $(el).addClass('active')
    }

    if ('ontouchstart' in document.documentElement) {
        $guests.on('touchstart', showGuestActions)
    } else {
        $guests.on('click', showGuestActions)
    }

    $('[data-offcanvas-toggle]').each(function(_index, offcanvasToggleEl) {
      var target ='[data-offcanvas-content="' + $(offcanvasToggleEl).data('offcanvas-toggle') + '"]'
      $(offcanvasToggleEl).click(function() {
        $(target).toggleClass('active')
      })
    });

    // Forms
    $('[data-remote="true"]').each(function(_index, formEl) {
      var submitTo, previewTo;

      var submit = function() {
        clearTimeout(submitTo)
        submitTo = setTimeout(function() {
          clearTimeout(previewTo)
          previewTo = setTimeout(function() {
            $(formEl).find('iframe').each(function(_index, iframeEl) {
              iframeEl.contentDocument.location.reload(true);
            })
          }, 1000)
          $(formEl).submit()
        }, 1000)
      }

      $(formEl).find(':input')
               .change(submit)
               .blur(submit)
               .focus(submit)
               .keyup(submit)

      $(formEl).find('[data-wysiwyg]').each(function (_index, el) {
        var wysiwyg = new Wysiwyg({
          markDownEl: $(el).find(".markdown").get(0),
          editorEl: $(el).find(".editor").get(0),
          mode: $(el).data('wysiwyg')
        })
        wysiwyg.subscribe('editableInput', submit)
        wysiwyg.subscribe('externalInteraction', submit)
      });
    })

    // Directions
    locations('ceremony_location')
    locations('reception_location')

  });
}).call(this);
