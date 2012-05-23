class AdminRouter extends Backbone.Router
  routes:
    "": "home"
    "words": "words"
    "sentences": "sentences"

  home: ->
    @showPage new AdminHomePageView

  words: ->
    @showPage new AdminWordsPageView

  sentences: ->
    @showPage new AdminSentencesPageView

  showPage: (pageView) ->
    pageView.render()
