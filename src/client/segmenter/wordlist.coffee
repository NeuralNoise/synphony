class Wordlist extends Backbone.Model
  initialize: ->
    console.log "wordlist hai"

class WordlistPageView extends Backbone.View
  initialize: ->
    console.log "wordlist page view hai"

  template: Handlebars.templates['segmenter/wordlist_page']

  render: ->
    ($ el).html @template()