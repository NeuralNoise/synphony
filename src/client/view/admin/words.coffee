define ['view/common/template', 'view/common/collection', 'view/word/plain', 'text!templates/admin/words_page.handlebars'],
(TemplateView, CollectionView, PlainWordView, hbsTemplate) ->
  class AdminWordsView extends TemplateView
    template: hbsTemplate

    constructor: (options) ->
      super options
      # @collection = @store.words
      # @wordsView = new CollectionView
      #   collection: @collection
      #   modelView: PlainWordView

    render: () ->
      super()
      # ($ '#words-list').html @wordsView.render().el
      @
