cc = null

L.Control.Compass = L.Control.extend
  options:
    position: 'topleft'

  onAdd: (map) ->
    cc = @

    window.addEventListener 'deviceorientation', @orientationChanged

    @container = L.DomUtil.create('div', 'leaflet-control-compass leaflet-bar leaflet-control hidden')
    link = L.DomUtil.create('a', 'leaflet-bar-part leaflet-bar-part-single fa fa-arrow-up', @container)
    @container

  orientationChanged: (e) ->
    L.DomUtil.removeClass(cc.container, 'hidden')
    heading = - window.orientation - e.webkitCompassHeading
    rotation = "rotate(#{heading}deg)"
    cc.container.style.webkitTransform = rotation    

L.control.compass = (options) ->
  new L.Control.Compass(options)
