distanceInM = (latlng) ->
  if lc._event && lc._active
    distance = latlng.distanceTo(lc._event.latlng)
    Number(distance.toFixed(1)).toLocaleString() + ' m'

showPopup = ->
  this.unbindPopup()
  content = distanceInM(this.getLatLng())
  this.bindPopup(content).openPopup() if content

addMarker = (latlng) ->
  marker = L.marker(latlng, { draggable: true })
    .addTo(map)
    .on 'dragend', saveMarkers
    .on 'dblclick', removeMarker
    .on 'click', showPopup
    
  markers.push marker

removeMarker = (e) ->
  this.closePopup()
  map.removeLayer(this)
  markers.splice(markers.indexOf(this), 1)
  saveMarkers()

markerForSaving = (m) ->
  m.getLatLng()

saveMarkers = ->
  store.set 'markers', markers.map(markerForSaving)

markers = []
stored = store.get('markers') || []
stored.forEach (m) ->
  addMarker(m)

map.on 'click', (e) ->
  addMarker(e.latlng)
  saveMarkers()
