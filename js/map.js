(function (L) {
  var google = new L.Google('ROADMAP');
  var satellite = new L.Google('SATELLITE');
  var terrain = new L.Google('TERRAIN');
  var topo = L.tileLayer('http://s3-eu-west-1.amazonaws.com/topo-slovenia/z{z}/{y}/{x}.png', {
    minZoom: 10,
    maxNativeZoom: 15,
    detectRetina: true,
    attribution: '© <a href="http://www.gu.gov.si/">GURS</a>'
  });

  var map = L.map('map', {
    layers: google,
    minZoom: 6
  }).setView([46, 14.7], 8);

  L.control.layers({ 'Google': google, 'Satellite': satellite, 'Terrain': terrain, 'Topo': topo }).addTo(map);

  var lc = L.control.locate({
    follow: true,
    locateOptions: {
      maxZoom: 15,
      watch: true
    }
  }).addTo(map);

  lc.locate();

  map.on('startfollowing', function () {
    map.on('dragstart', lc.stopFollowing);
  }).on('stopfollowing', function () {
    map.off('dragstart', lc.stopFollowing);
  });

  function orientationBugfix() {
    window.scrollTo(0, 0);
  }

  window.addEventListener('orientationchange', orientationBugfix);
  orientationBugfix();
}(L));
