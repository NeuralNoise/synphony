define ['backbone', 'view/common/layout', 'view/common/menu',
        'view/common/sidebar', 'view/admin/words',
        'view/admin/sentences', 'view/gpc/button', 'view/common/collection'],
(Backbone, Layout, MenuView, SidebarView, WordsView, SentencesView, GPCButtonView, CollectionView) ->
  class AdminRouter extends Backbone.Router
    routes:
      "": "home"
      "words": "words"
      "sentences": "sentences"

    menu:
      "Words": "#words"
      "Sentences": "#sentences"

    sidebar: ->
      'Spelling Patterns': @makeSpellingPatterns()

    constructor: (options) ->
      super options
      @store = options.store
      @layout = new Layout
        menu: "#main-menu"
        content: "#main-content"
        sidebar: "#toolbar-content"
      @setup = false


    home: ->
      @navigate 'words', trigger: true, replace: true

    words: ->
      console.log "Showing admin words page"
      @showContent new WordsView { @store }

    sentences: ->
      console.log "Showing admin sentences page"
      @showContent new SentencesView { @store }

    makeSpellingPatterns: ->
      new CollectionView
        id: 'spelling-patterns'
        collection: @store.sequences().first().elements()
        knownGPCs: @store.knownGPCs()
        modelView: GPCButtonView

    setupDefaultViews: ->
      return if @setup
      @setup = true
      @layout.menu.render new MenuView model: { @menu }
      @layout.sidebar.render new SidebarView model: {sections: @sidebar()}

    showContent: (view) ->
      @setupDefaultViews()
      @layout.content.render(view)
