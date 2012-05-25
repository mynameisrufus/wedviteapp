zoom =
  out: 14
  in: 16

cords =
  lat: 13.731547730050778
  lng: 100.56798934936523

attrIds = [
  "lat",
  "lng",
  "address_components",
  "types",
  "formatted_address",
  "formatted_phone_number",
  "international_phone_number",
  "name",
  "vicinity",
  "website",
  "google_url",
  "google_id"
]

uiIds = [
  "map",
  "search"
]

getElements = (prefix = '') ->
  elements = {}
  addAttrEl = (key) ->
    elements[key] = document.getElementById "#{prefix}_#{key}"
  addUiEl = (key) ->
    elements[key] = document.getElementById "#{prefix}_#{key}"
  addAttrEl key for key in attrIds
  addUiEl key for key in uiIds
  elements

getImage = (image) ->
  new google.maps.MarkerImage(
    image,
    new google.maps.Size(71, 71),
    new google.maps.Point(0, 0),
    new google.maps.Point(17, 34),
    new google.maps.Size(35, 35)
  )

animateMarker = (marker) ->
  marker.setAnimation if marker.getAnimation? then null else google.maps.Animation.BOUNCE

dragMarkerCallback = (map, marker, infowindow, elements, image) ->
  point = marker.getPosition()
  map.panTo point
  updateElements elements,
    lng: point.lng()
    lat: point.lat()
  infowindow.close()
  marker.setIcon image

updateMap = (map, marker, place) ->
  marker.setPosition place.geometry.location
  map.panTo place.geometry.location
  map.setZoom zoom.in
  marker.setIcon getImage place.icon

updateElementsFromPlace = (elements, place) ->
  updateElements elements,
    google_url: place.url
    google_id: place.id
    lng: place.geometry.location.lng()
    lat: place.geometry.location.lat()
  updateElements elements, place

updateInfoWindow = (map, infowindow, marker, place) ->
  address = ''
  if (place.address_components)
    address = [(place.address_components[0] &&
                place.address_components[0].short_name || ''),
               (place.address_components[1] &&
                place.address_components[1].short_name || ''),
               (place.address_components[2] &&
                place.address_components[2].short_name || '')
              ].join(' ')
  infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address)
  infowindow.open map, marker

addMap = (lat, lng, elements) ->
  new google.maps.Map elements.map,
    center: new google.maps.LatLng lat, lng
    zoom: zoom.out
    mapTypeId: google.maps.MapTypeId.ROADMAP

addMarker = (map, centerPoint) ->
  new google.maps.Marker
    map: map
    draggable:true
    animation: google.maps.Animation.DROP
    position: centerPoint

addAutocomplete = (map, el) ->
  autocomplete = new google.maps.places.Autocomplete el
  autocomplete.bindTo 'bounds', map
  autocomplete
  
updateElements = (elements, parts) ->
  for partKey, partValue of parts
    for elementKey, el of elements
      if elementKey == partKey
        if typeof(partValue) == 'object'
          el.value = JSON.stringify partValue
        else
          el.value = partValue

window.locations = (prefix) ->
  elements     = getElements(prefix)
  startLat     = if elements.lat.value == "" then cords.lat else elements.lat.value
  startLng     = if elements.lng.value == "" then cords.lng else elements.lng.value
  map          = addMap startLat, startLng, elements
  centerPoint  = new google.maps.LatLng startLat, startLng
  marker       = addMarker map, centerPoint
  infowindow   = new google.maps.InfoWindow()
  autocomplete = addAutocomplete map, elements.search

  defaultImage = getImage("http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png")
  marker.setIcon defaultImage

  google.maps.event.addListener autocomplete, 'place_changed', ->
    place = autocomplete.getPlace()
    updateMap map, marker, place
    updateElementsFromPlace elements, place
    updateInfoWindow map, infowindow, marker, place

  google.maps.event.addListener marker, 'click', ->
    animateMarker marker

  google.maps.event.addListener marker, "dragend", ->
    dragMarkerCallback map, marker, infowindow, elements, defaultImage
