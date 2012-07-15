define [],
() ->
  # Not used at the moment. This will be the language analysis interface.
  class SegmenterRouter extends Backbone.Router
    routes:
      "": "wordlist"

    wordlist: ->
      wordlist = new Wordlist
      wordlist.fetch()
      wordlistPageView = new WordlistPageView model: wordlist
      ($ '#main').empty()
      ($ '#main').append wordlistPageView.render().el
