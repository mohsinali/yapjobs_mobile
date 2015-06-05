$ ->
  placeSearch = undefined
  autocomplete = undefined
  componentForm = 
    street_number: 'short_name'
    route: 'long_name'
    locality: 'long_name'
    administrative_area_level_1: 'short_name'
    country: 'long_name'
    postal_code: 'short_name'

  initialize = ->
    # Create the autocomplete object, restricting the search
    # to geographical location types.
    autocomplete = new (google.maps.places.Autocomplete)(document.getElementById('autocomplete_address'), types: [ 'geocode' ])
    # When the user selects an address from the dropdown,
    # populate the address fields in the form.
    google.maps.event.addListener autocomplete, 'place_changed', ->
      fillInAddress();
      return
    return

  fillInAddress = ->
    place = autocomplete.getPlace()
    geometry = autocomplete.getPlace().geometry.location
    
    if $("#current_position").length > 0
      $("#current_position").val(geometry.lat()+","+geometry.lng())

  ##########################################################################################
  # Bias the autocomplete object to the user's geographical location,
  # as supplied by the browser's 'navigator.geolocation' object.
  geolocate = ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) ->
        geolocation = new (google.maps.LatLng)(position.coords.latitude, position.coords.longitude)
        circle = new (google.maps.Circle)(
          center: geolocation
          radius: position.coords.accuracy)
        autocomplete.setBounds circle.getBounds()
        return
    return

  if $("#autocomplete_address").length > 0
    initialize()