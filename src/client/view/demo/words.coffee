define ['view/common/template', 'view/common/composite',
  'view/common/collection', 'view/word/list', 'interactor/known_focus_search'
  'text!templates/demo/words.handlebars'],
(TemplateView, CompositeView, CollectionView, WordListView, KnownFocusSearch, hbsTemplate) ->
  # The demo Words page.
  class WordsView extends CompositeView
    id: 'words-page'

    constructor: (options) ->
      super options
      @addView new TemplateView template: hbsTemplate
      @addView new WordListView { @interactor }
