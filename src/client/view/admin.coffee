class AdminPageView extends PageView
  toolbar: ->
    'Spelling Patterns': (new GPCButtonsView collection: @store.gpcs, id: "spelling-patterns")

  menu: ->
    'Home': '#'
    'Words': '#words'
    'Sentences': '#sentences'

  constructor: (options) ->
    @store = options.store

    super options

class AdminHomePageView extends AdminPageView
  template: 'admin/home_page'

class AdminSentencesPageView extends AdminPageView
  template: 'admin/sentences_page'

class AdminWordsPageView extends AdminPageView
  template: 'admin/words_page'

  constructor: (options) ->
    super options
    @collection = @store.words
    @wordsView = new WordsListView collection: @collection

  render: () ->
    super()
    ($ '#words-list').empty()
    ($ '#words-list').append @wordsView.render().el
    @