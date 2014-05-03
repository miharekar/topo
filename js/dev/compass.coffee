cc = null

L.Control.Compass = L.Control.extend
  options:
    position: 'topleft'
    element: null
    offset: 0

  onAdd: (map) ->
    cc = @

    Compass.watch @styleNeedle

    @container = L.DomUtil.create('div', 'leaflet-control-compass leaflet-bar leaflet-control hidden')
    link = L.DomUtil.create('a', 'leaflet-bar-part leaflet-bar-part-single fa', @container)
    @icon = L.DomUtil.create('i', 'fa fa-arrow-up', link)

    @options.element = @icon unless @options.element

    @container

  styleNeedle: (heading) ->
    if cc.options.element == cc.icon
      L.DomUtil.removeClass(cc.container, 'hidden')

    rotation = "rotate(#{cc.options.offset - heading}deg)"
    cc.options.element.style.webkitTransform = rotation

    L.DomUtil.removeClass(cc.options.element, 'accurate')
    L.DomUtil.removeClass(cc.options.element, 'very-accurate')

    c = Math.sin(heading * (Math.PI / 360)) * 100
    if Math.abs(c) <= 5
      L.DomUtil.addClass(cc.options.element, 'very-accurate')
    else if Math.abs(c) <= 20
      L.DomUtil.addClass(cc.options.element, 'accurate')

L.control.compass = (options) ->
  new L.Control.Compass(options)
