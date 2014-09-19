# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class RichMarkerBuilder extends Gmaps.Google.Builders.Marker #inherit from builtin builder
  #override create_marker method
  create_marker: ->
    options = _.extend @marker_options(), @rich_marker_options()
    @serviceObject = new RichMarker options #assign marker to @serviceObject

  rich_marker_options: ->
    marker = document.createElement("div")
    marker.setAttribute 'class', 'marker_container'
    marker.innerHTML = @args.title
    { content: marker }


  create_infowindow: ->
    return null unless _.isString @args.infowindow

    boxText = document.createElement("div")
    boxText.setAttribute("class", 'yellow') #to customize
    boxText.innerHTML = @args.infowindow
    @infowindow = new InfoBox(@infobox(boxText))

    # add @bind_infowindow() for < 2.1

  infobox: (boxText)->
    content: boxText
    pixelOffset: new google.maps.Size(-140, 0)
    boxStyle:
      width: "280px"



@getLocation = ->
  current_location = {}
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition ((position) ->
      current_location = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    ), ->
      handleNoGeolocation true

    if current_location === {}
      current_location =
        lat: ->
          null

        lng: ->
          null
  else
    current_location =
      lat: ->
        null

      lng: ->
        null

    handleNoGeolocation false
  current_location


		  	
@buildMap = (markers) ->
	handler = Gmaps.build 'Google', { builders: { Marker: RichMarkerBuilder} } #dependency injection

	handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
	  markers = handler.addMarkers(markers)
	  handler.bounds.extendWith(markers)
	  handler.fitMapToBounds()

