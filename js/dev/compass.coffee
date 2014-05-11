cc = null

L.Control.Compass = L.Control.extend
  options:
    position: 'topleft'
    element: null
    offset: 0

  onAdd: (map) ->
    cc = @

    Compass.needGPS ->
      alert('Go outside and provide GPS')
    .needMove ->
      alert('Move forward')
    .watch (heading) =>
      L.DomUtil.removeClass(@container, 'hidden')
      heading += window.orientation
      @colorNeedle(heading)
      @turnNeedle(heading)
      @showHeading(heading) if @options.element != @icon

    @container = L.DomUtil.create('div', 'leaflet-control-compass leaflet-bar leaflet-control hidden')
    @link = L.DomUtil.create('a', 'leaflet-bar-part leaflet-bar-part-single fa', @container)
    @icon = L.DomUtil.create('i', 'fa fa-arrow-up', @link)

    @options.element = @icon unless @options.element

    @container

  colorElement: (offset, accuracy, klass) ->
    action = if offset <= accuracy then 'addClass' else 'removeClass'
    L.DomUtil[action](@options.element, klass)

  colorNeedle: (heading) ->
    offset = Math.sin(heading * (Math.PI / 360)) * 100
    @colorElement(offset, 15, 'accurate')
    @colorElement(offset, 3, 'very')

  turnNeedle: (heading) ->
    rotation = @options.offset - heading
    @options.element.style.webkitTransform = "rotate(#{rotation}deg)"

  showHeading: (heading) ->
    @link.innerHTML = "#{Math.round(heading)}°"

L.control.compass = (options) ->
  new L.Control.Compass(options)
