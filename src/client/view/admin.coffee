class AdminPageView extends PageView
  toolbar: ->
    'Spelling Patterns': (new GPCButtonsView collection: @gpcs, id: "spelling-patterns")

  menu: ->
    'Home': '#'
    'Words': '#words'
    'Sentences': '#sentences'

  constructor: (options) ->
    @gpcs = new GPCs
    @gpcs.fetch()

    super options

class AdminHomePageView extends AdminPageView
  template: 'admin/home_page'

class AdminSentencesPageView extends AdminPageView
  template: 'admin/sentences_page'

class AdminWordsPageView extends AdminPageView
  template: 'admin/words_page'

  constructor: (options) ->
    super options
    @collection = new Words
    @collection.fetch()
    @wordsView = new WordsListView collection: @collection

  render: () ->
    super()
    ($ '#words-list').empty()
    ($ '#words-list').append @wordsView.render().el
    @