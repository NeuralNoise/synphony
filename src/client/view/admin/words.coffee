define ['view/common/template', 'view/common/composite',
  'view/common/collection', 'view/word/list', 'model/known_focus_search'
  'text!templates/admin/words_page.handlebars'],
(TemplateView, CompositeView, CollectionView, WordListView, KnownFocusSearch, hbsTemplate) ->
  class AdminWordsView extends CompositeView
    id: 'words-page'

    constructor: (options) ->
      super options
      @store = options.store
      @collection = @store.words()
      @knownGPCs = @store.knownGPCs()
      @search = new KnownFocusSearch @collection
      @addView new TemplateView template: hbsTemplate
      @addView new WordListView { @collection, @knownGPCs, filter: => @filterWords() }

    filterWords: ->
      knownGPCs = @knownGPCs.models
      focusGPCs = if @knownGPCs.isEmpty() then [] else [ @knownGPCs.last() ]
      @search.getKnownFocusItems knownGPCs, focusGPCs
