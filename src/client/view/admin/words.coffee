define ['view/common/template', 'view/common/collection', 'view/word/list', 'text!templates/admin/words_page.handlebars'],
(TemplateView, CollectionView, WordListView, hbsTemplate) ->
  class AdminWordsView extends TemplateView
    template: hbsTemplate

    constructor: (options) ->
      super options
      @store = options.store
      @collection = @store.words()
      @userGPCs = @store.userGPCs()
      @listView = new WordListView { @collection, @userGPCs }
      # @wordsView = new CollectionView
      #   collection: @collection
      #   modelView: PlainWordView

    render: () ->
      super()
      (@$ '#words-list').html @listView.render().el
      @
