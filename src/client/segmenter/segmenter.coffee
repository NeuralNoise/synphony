class SegmenterRouter extends Backbone.Router
  routes:
    "": "wordlist"

  wordlist: ->
    wordlist = new Wordlist
    wordlist.fetch()
    wordlistPageView = new WordlistPageView model: wordlist
    ($ '#main').empty()
    ($ '#main').append wordlistPageView.render().el
