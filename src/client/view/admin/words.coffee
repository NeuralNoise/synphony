define ['view/common/template', 'view/common/collection', 'view/word/list', 'text!templates/admin/words_page.handlebars'],
(TemplateView, CollectionView, WordListView, hbsTemplate) ->
  class AdminWordsView extends TemplateView
    template: hbsTemplate

    constructor: (options) ->
      super options
      @store = options.store
      @collection = @store.words()
      @userGPCs = @store.userGPCs()
      @listView = new WordListView { @collection, @userGPCs, filter: => @filterWords() }
      # @wordsView = new CollectionView
      #   collection: @collection
      #   modelView: PlainWordView

    filterWords: ->
      knownGPCs = @userGPCs.getKnownGPCs()
      focusGPCs = @userGPCs.getFocusGPCs()
      @collection.getKnownFocusGPCWords knownGPCs, focusGPCs

    render: () ->
      super()
      (@$ '#words-list').html @listView.render().el
      @
