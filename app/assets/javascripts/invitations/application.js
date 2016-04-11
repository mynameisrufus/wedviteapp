//= require jquery
//= require tether
//= require bootstrap
//= require bootstrap-offcanvas
//= require_tree .

function makeMap(lat, lng, id) {
  var myOptions = {
    center: new google.maps.LatLng(lat, lng),
    zoom: 8,
    zoomControl: false,
    disableDoubleClickZoom: true,
    disableDefaultUI: true,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById(id),
      myOptions);

  var centerPoint  = new google.maps.LatLng(lat, lng)

  var marker = new google.maps.Marker({
      map: map,
      draggable: false,
      animation: google.maps.Animation.DROP,
      position: centerPoint
  })

  var infowindow   = new google.maps.InfoWindow()
  var defaultImage = new google.maps.MarkerImage(
      "http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png",
      new google.maps.Size(71, 71),
      new google.maps.Point(0, 0),
      new google.maps.Point(17, 34),
      new google.maps.Size(35, 35)
  )

  marker.setIcon(defaultImage)
}

$(function() {
  $('[data-toggle="offcanvas"]').click(function () {
      $('.row-offcanvas').toggleClass('active')
  });

  var $alert = $('.alert')

  var remove = function() {
      $alert.fadeOut('slow', function() {
          $(this).remove()
      })
  }

  var to = setTimeout(remove, 5000)

  $alert.find('.close').on('click', function(){
      clearTimeout(to)
      remove()
  })

  if (window.directions) {
    $.each(window.directions, function(_index, direction) {
      makeMap(direction.lat, direction.lng, direction.id)
    })
  }

  $('[data-toggle="autogrow"]').each(function (_index, el) {
    $(el).autogrow();
  })
});
