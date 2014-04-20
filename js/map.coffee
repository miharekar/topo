orientationBugfix = ->
  window.scrollTo 0, 0

google = new L.Google("ROADMAP")
satellite = new L.Google("SATELLITE")
terrain = new L.Google("TERRAIN")
topo = L.tileLayer 'http://s3-eu-west-1.amazonaws.com/topo-slovenia/z{z}/{y}/{x}.png', {
  minZoom: 10
  maxNativeZoom: 15
  detectRetina: true
  attribution: '© <a href="http://www.gu.gov.si/">GURS</a>'
}

map = L.map('map', {
  layers: google
  minZoom: 6
}).setView([46, 14.7], 8)

L.control.scale().addTo(map)

L.control.layers({
  Google: google
  Satellite: satellite
  Terrain: terrain
  Topo: topo
}).addTo(map)

lc = L.control.locate({
  follow: true
  locateOptions:{
    maxZoom: 15
    watch: true
  }
}).addTo(map)

map.on 'startfollowing', ->
  map.on 'dragstart', lc.stopFollowing

map.on 'stopfollowing', ->
  map.off 'dragstart', lc.stopFollowing

lc.locate()

window.addEventListener 'orientationchange', orientationBugfix
orientationBugfix()
