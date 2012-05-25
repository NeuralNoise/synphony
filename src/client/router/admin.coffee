class AdminRouter extends Backbone.Router
  routes:
    "": "home"
    "words": "words"
    "sentences": "sentences"

  constructor: (options) ->
    @store = options.store

    super options

  home: ->
    @showPage new AdminHomePageView { @store }

  words: ->
    @showPage new AdminWordsPageView { @store }

  sentences: ->
    @showPage new AdminSentencesPageView { @store }

  showPage: (pageView) ->
    pageView.render()
