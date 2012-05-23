class WordsListView extends TemplateView
  template: 'words/words_list'

  wordView: (word) ->
    new PlainWordView model: word

  constructor: (options) ->
    super options

    @collection.on 'reset', @onCollectionReset, @

  onCollectionReset: () ->
    @_views = null
    console.log "Words reset"
    @render()

  views: () ->
    log @collection.length
    if not @_views
      @_views = @collection.map (word) => @wordView(word)
    @_views

  render: () ->
    super()
    $ul = @$ 'ul'
    $ul.empty()
    _.each @views(), (view) ->
      $ul.append view.render().el
    @

class PlainWordView extends TemplateView
  template: 'words/plain_word'
  tagName: 'span'
  tagClass: 'word'
