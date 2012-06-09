define ['backbone', 'view/common/layout', 'view/common/menu',
        'view/common/sidebar', 'view/admin/home', 'view/admin/words',
        'view/admin/sentences', 'view/gpc/button', 'view/common/collection'],
(Backbone, Layout, MenuView, SidebarView, HomeView, WordsView, SentencesView, GPCButtonView, CollectionView) ->
  class AdminRouter extends Backbone.Router
    routes:
      "": "home"
      "words": "words"
      "sentences": "sentences"

    menu:
      "Home": "#"
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
      console.log "Showing admin home page"
      @showContent new HomeView { @store }

    words: ->
      console.log "Showing admin words page"
      @showContent new WordsView { @store }

    sentences: ->
      console.log "Showing admin sentences page"
      @showContent new SentencesView { @store }

    makeSpellingPatterns: ->
      new CollectionView
        id: 'spelling-patterns'
        collection: @store.userGPCs()
        modelView: GPCButtonView

    setupDefaultViews: ->
      return if @setup
      @setup = true
      @layout.menu.render new MenuView model: { @menu }
      @layout.sidebar.render new SidebarView model: {sections: @sidebar()}

    showContent: (view) ->
      @setupDefaultViews()
      @layout.content.render(view)
