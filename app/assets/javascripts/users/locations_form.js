(function() {
  var addAutocomplete, addMap, addMarker, animateMarker, attrIds, cords, dragMarkerCallback, getElements, getImage, uiIds, updateElements, updateElementsFromPlace, updateInfoWindow, updateMap, zoom;

  zoom = {
    out: 14,
    "in": 16
  };

  cords = {
    lat: 13.731547730050778,
    lng: 100.56798934936523
  };

  attrIds = ["lat", "lng", "address_components", "types", "formatted_address", "formatted_phone_number", "international_phone_number", "name", "vicinity", "website", "google_url", "google_id"];

  uiIds = ["map", "search"];

  getElements = function(prefix) {
    var addAttrEl, addUiEl, elements, i, j, key, len, len1;
    if (prefix == null) {
      prefix = '';
    }
    elements = {};
    addAttrEl = function(key) {
      return elements[key] = document.getElementById(prefix + "_" + key);
    };
    addUiEl = function(key) {
      return elements[key] = document.getElementById(prefix + "_" + key);
    };
    for (i = 0, len = attrIds.length; i < len; i++) {
      key = attrIds[i];
      addAttrEl(key);
    }
    for (j = 0, len1 = uiIds.length; j < len1; j++) {
      key = uiIds[j];
      addUiEl(key);
    }
    return elements;
  };

  getImage = function(image) {
    return new google.maps.MarkerImage(image, new google.maps.Size(71, 71), new google.maps.Point(0, 0), new google.maps.Point(17, 34), new google.maps.Size(35, 35));
  };

  animateMarker = function(marker) {
    return marker.setAnimation(marker.getAnimation != null ? null : google.maps.Animation.BOUNCE);
  };

  dragMarkerCallback = function(map, marker, infowindow, elements, image) {
    var point;
    point = marker.getPosition();
    map.panTo(point);
    updateElements(elements, {
      lng: point.lng(),
      lat: point.lat()
    });
    infowindow.close();
    return marker.setIcon(image);
  };

  updateMap = function(map, marker, place) {
    marker.setPosition(place.geometry.location);
    map.panTo(place.geometry.location);
    map.setZoom(zoom["in"]);
    return marker.setIcon(getImage(place.icon));
  };

  updateElementsFromPlace = function(elements, place) {
    updateElements(elements, {
      google_url: place.url,
      google_id: place.id,
      lng: place.geometry.location.lng(),
      lat: place.geometry.location.lat()
    });
    return updateElements(elements, place);
  };

  updateInfoWindow = function(map, infowindow, marker, place) {
    var address;
    address = '';
    if (place.address_components) {
      address = [place.address_components[0] && place.address_components[0].short_name || '', place.address_components[1] && place.address_components[1].short_name || '', place.address_components[2] && place.address_components[2].short_name || ''].join(' ');
    }
    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    return infowindow.open(map, marker);
  };

  addMap = function(lat, lng, elements) {
    return new google.maps.Map(elements.map, {
      center: new google.maps.LatLng(lat, lng),
      zoom: zoom.out,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
  };

  addMarker = function(map, centerPoint) {
    return new google.maps.Marker({
      map: map,
      draggable: true,
      animation: google.maps.Animation.DROP,
      position: centerPoint
    });
  };

  addAutocomplete = function(map, el) {
    var autocomplete;
    autocomplete = new google.maps.places.Autocomplete(el);
    autocomplete.bindTo('bounds', map);
    return autocomplete;
  };

  updateElements = function(elements, parts) {
    var el, elementKey, partKey, partValue, results;
    results = [];
    for (partKey in parts) {
      partValue = parts[partKey];
      results.push((function() {
        var results1;
        results1 = [];
        for (elementKey in elements) {
          el = elements[elementKey];
          if (elementKey === partKey) {
            if (typeof partValue === 'object') {
              results1.push(el.value = JSON.stringify(partValue));
            } else {
              results1.push(el.value = partValue);
            }
          } else {
            results1.push(void 0);
          }
        }
        return results1;
      })());
    }
    return results;
  };

  window.locations = function(prefix) {
    var autocomplete, centerPoint, defaultImage, elements, infowindow, map, marker, startLat, startLng;
    elements = getElements(prefix);
    startLat = elements.lat.value === "" ? cords.lat : elements.lat.value;
    startLng = elements.lng.value === "" ? cords.lng : elements.lng.value;
    map = addMap(startLat, startLng, elements);
    centerPoint = new google.maps.LatLng(startLat, startLng);
    marker = addMarker(map, centerPoint);
    infowindow = new google.maps.InfoWindow();
    autocomplete = addAutocomplete(map, elements.search);
    defaultImage = getImage("http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png");
    marker.setIcon(defaultImage);
    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      var place;
      place = autocomplete.getPlace();
      updateMap(map, marker, place);
      updateElementsFromPlace(elements, place);
      return updateInfoWindow(map, infowindow, marker, place);
    });
    google.maps.event.addListener(marker, 'click', function() {
      return animateMarker(marker);
    });
    return google.maps.event.addListener(marker, "dragend", function() {
      return dragMarkerCallback(map, marker, infowindow, elements, defaultImage);
    });
  };

}).call(this);
