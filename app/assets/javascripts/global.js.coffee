$ ->
  $(document).on "click", "#btn_sign_in", ->
    $('.preloader').show()

  $(document).on "click", "#btn_sign_up", ->
    $('.preloader').show()

  

  ###############################################
  ## Geo Location - Google
  ## Ref: https://developers.google.com/web/fundamentals/device-access/user-location/obtain-location?hl=en#check-for-compatibility
  ###############################################

  # Initialize current position with empty string
  current_position = ""
  address = ""
  new google.maps.Geocoder();

  # check for Geolocation support
  if (navigator.geolocation)
    console.log 'Geolocation is supported!'
  
  else 
    console.log 'Geolocation is not supported for this Browser/OS version yet.'

  ################################################
  ##
  ## This method sets the current lat-long in current_position
  getPosition = ->
    navigator.geolocation.getCurrentPosition (position) ->      
      current_position = position.coords.latitude+","+position.coords.longitude
      getAddress(position.coords.latitude, position.coords.longitude)

      ## Call this method to calculate distance from current_location to jobseekers location.
      # if gon.business_location != undefined
      #   getDistance(current_position, gon.business_location)


  ################################################
  ## 
  getAddress = (myLatitude, myLongitude) ->
    # create a geocoder object
    geocoder = new (google.maps.Geocoder)
    
    # turn coordinates into an object
    location = new (google.maps.LatLng)(myLatitude, myLongitude)
    geocoder.geocode { 'latLng': location }, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        # if geocode success
        address = results[0].formatted_address        

        $("#location").val(address)

        if $("#autocomplete_address").length > 0
          if $("#autocomplete_address").val().length == 0
            $("#autocomplete_address").val(address)
        
        $("#find_a_job_location").val(address)
        
        if $(".current_position").length > 0 && !$(".current_position").val()
          $('.current_position').val(myLatitude+","+myLongitude)
        else
          if $(".current_position").length > 0 && $(".current_position").val().length < 1
            $(".current_position").val("78,0")
        
        if $("#current_position").length > 0 && !$("#current_position").val()
          $("#current_position").val(myLatitude+","+myLongitude)
        else
          if $("#current_position").length > 0 && $("#current_position").val().length < 1
            $("#current_position").val("51,0")
      else
        console.log 'Geocode failure: ' + status
      
    return

  rad = (x) ->
    x * Math.PI / 180

  getDistance = (currentLocation, userLocation) ->
    loc1 = currentLocation.split(',')
    loc2 = userLocation.split(',')
    
    loc1 = [parseFloat(loc1[0]), parseFloat(loc1[1])]
    loc2 = [parseFloat(loc2[0]), parseFloat(loc2[1])]

    R = 3959
    # Earth’s mean radius in miles
    dLat = rad(loc2[0] - loc1[0])
    dLong = rad(loc2[1] - loc1[1])
    a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(rad(loc1[0])) * Math.cos(rad(loc2[0])) * Math.sin(dLong / 2) * Math.sin(dLong / 2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    # returns the distance in miles
    d = R * c

    # Update distance with id = "distance_jobseeker"
    set_distance(d)

  set_distance = (distance) ->
    rounded_off_distance = Math.round(distance)

    if distance < 1
      $("#distance_jobseeker").html("Less than a mile away.")
      $(".distance_business").html("LESS THAN A MILE AWAY")
    else if rounded_off_distance == 1
      $("#distance_jobseeker").html(rounded_off_distance + " mile away.")
      $(".distance_business").html(rounded_off_distance + " MILE AWAY")
    else
      $("#distance_jobseeker").html(rounded_off_distance + " miles away.")
      $(".distance_business").html(rounded_off_distance + " MILES AWAY")


  #########################################################
  ## Call getPosition to set current location and address
  getPosition()