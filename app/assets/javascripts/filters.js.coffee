jQuery ($) ->
  ($ ".filter a").live 'click', ->
    _gaq ||= []
    _gaq.push(['_trackEvent', 'Filter', text = ($ @).text()])