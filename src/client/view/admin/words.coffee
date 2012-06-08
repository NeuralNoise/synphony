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
