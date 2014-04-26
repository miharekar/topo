google = new L.Google('ROADMAP')
satellite = new L.Google('SATELLITE')
terrain = new L.Google('TERRAIN')
topo = L.tileLayer 'http://s3-eu-west-1.amazonaws.com/topo-slovenia/z{z}/{y}/{x}.png', {
  minZoom: 10
  maxNativeZoom: 15
  detectRetina: true
  attribution: '© <a href="http://www.gu.gov.si/">GURS</a>'
  unloadInvisibleTiles: false
}

map = L.map('map', {
  layers: google
  minZoom: 6
}).setView([46, 14.7], 8)

L.control.layers({
  Google: google
  Satellite: satellite
  Terrain: terrain
  Topo: topo
}).addTo(map)

L.control.scale({ imperial: false }).addTo(map)

lc = L.control.locate({ setView: false }).addTo(map)
L.control.markers({ locate: lc }).addTo(map)
L.control.compass({ element: lc.icon, offset: -45 }).addTo(map)

lc.locate()
