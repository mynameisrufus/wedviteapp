//= require jquery
//= require tether
//= require bootstrap
//= require medium-editor
//= require to-markdown
//= require rangy
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
    $("#menu").dropdown();

    var $modal = $('#modal-from-dom')

    $('a.modal-me').on('click', function(event) {
        event.preventDefault()
        $.get(this.href, function(data) {
            $modal.html(data).modal('show')
        })
    })

    var $container = $('.slide-deck'),
        $sections  = $container.find('.slide'),
        $navItems  = $('.nav-wedvite li')

    $sections.slideDeck({
        speed: 500,
        easing: $.support.transition ? 'ease' : 'swing'
    })

    $container.css('height', $($sections.get(0)).height())
    $sections.on('incomming', function(event, elem) {
        $container.css('height', $(this).height())
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

    $navItems.find('a').on('click', function(event) {
        event.preventDefault()

        // toggle active states
        $navItems.removeClass('active')
        $(this).parent().addClass('active')

        // transition
        var id = this.hash.replace(/#/, '')
        $sections.change(id)
        return false
    })
    
    $('*[rel=popover]').popover({placement: 'right'})

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

    // our day
    var $form = $('#ourday form'),
        $cere = $('#wedding_ceremony_what'),
        $rece = $('#wedding_reception_what'),
        $span = $form.find('.form-actions span'),
        to    = null

    var save = function() {
        $span.html('Saving....')
        $.ajax({
            type: 'PUT',
            url: $form.attr('action'),
            data: {
                wedding: {
                    ceremony_what: $cere.val(),
                    reception_what: $rece.val()
                }
            },
            success: function(data) {
                $span.html('')
            },
            dataType: 'json'
        })
    }

    var autosave = function() {
        clearTimeout(to)
        to = setTimeout(save, 10000)
    }

    $cere.on('keyup', autosave)
    $rece.on('keyup', autosave)

    // Stationary
    var $stationeries = $('.stationeries'),
        $stationery   = $stationeries.find('.stationery'),
        $next         = $('.paddle.right'),
        $previous     = $('.paddle.left'),
        current       = null

    var load = function(elem, spin) {
        var $elem = $(elem).find('.wrapper'),
            src = $elem.data('src'),
            $img = $(new Image)

        var callback = function(){
            $elem.html($img)
        }

        $img.one('load', callback)
        $img.attr('src', src)
        $img.each(function() {
            if (this.complete) return $(this).trigger('load')
            if (spin !== false) return new Spinner({color: "#2B617E"}).spin($elem.get(0))
            return
        })

        return $img
    }

    var move = function(n, spin) {
        $stationery.hide().each(function(index, elem) {
            var id = $(elem).data('id')
            if (id === n) {
                current = id
                $(elem).show()
                return load(elem, spin)
            }
        })

        return current
    }

    $next.on('click', function(event) {
        event.preventDefault()
        var n = ((current + 1) === $stationery.length) ? 0 : (current + 1)
        move(n)
    })

    $previous.on('click', function(event) {
        event.preventDefault()
        var n = (current === 0) ? ($stationery.length - 1) : (current - 1)
        move(n)
    })

    // Details
    var $container = $('.slide-deck'),
        $sections  = $container.find('.slide'),
        $navItems  = $('.nav-wedvite li')

    $sections.slideDeck({
        speed: 500,
        easing: $.support.transition ? 'ease' : 'swing'
    })

    $container.css('height', $($sections.get(0)).height())
    $sections.on('incomming', function(event, elem) {
        $container.css('height', $(this).height())
    })


    $navItems.find('a').on('click', function(event) {
        event.preventDefault()

        // toggle active states
        $navItems.removeClass('active')
        $(this).parent().addClass('active')

        // transition
        var id = this.hash.replace(/#/, '')
        $sections.change(id)
        return false
    })

    $sections.on('entered', function(event, elem) {
        if (this.id === 'ceremony_directions') locations('ceremony_location')
    })

    $sections.on('entered', function(event, elem) {
        if (this.id === 'reception_directions') locations('reception_location')
    })

    // WYSIWYG
  $('[data-wysiwyg]').each(function (_index, el) {
    var wysiwyg = new Wysiwyg({
      markDownEl: $(el).find(".markdown").get(0),
      editorEl: $(el).find(".editor").get(0),
      mode: $(el).data('wysiwyg')
    })
  });

  });
}).call(this);
