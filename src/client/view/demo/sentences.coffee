define ['view/common/template', 'view/common/composite',
  'view/common/collection', 'view/sentence/list', 'interactor/known_focus_search'
  'text!templates/demo/sentences.handlebars'],
(TemplateView, CompositeView, CollectionView, SentenceListView, KnownFocusSearch, hbsTemplate) ->
  # The main Demo Sentences page.
  class SentencesView extends CompositeView
    id: 'sentences-page'

    constructor: (options) ->
      super options
      @store = options.store
      @collection = @store.sentences()
      @knownGPCs = @store.knownGPCs()
      @search = new KnownFocusSearch @collection
      @addView new TemplateView template: hbsTemplate
      @addView new SentenceListView { @collection, @knownGPCs, filter: => @filterSentences() }

    filterSentences: ->
      knownGPCs = @knownGPCs.models
      focusGPCs = if @knownGPCs.isEmpty() then [] else [ @knownGPCs.last() ]
      @search.getKnownFocusItems knownGPCs, focusGPCs
