class SegmenterRouter extends Backbone.Router
  routes:
    "": "wordlist"

  wordlist: ->
    wordlist = new Wordlist
    wordlistPageView = new WordlistPageView model: wordlist
    ($ 'body').append wordlistPageView.render().el
