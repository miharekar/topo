orientationBugfix = ->
  window.scrollTo 0, 0

window.addEventListener 'orientationchange', orientationBugfix
orientationBugfix()
