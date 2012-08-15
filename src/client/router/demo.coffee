define ['backbone', 'view/common/menu',
        'view/common/sidebar', 'view/demo/words',
        'view/demo/sentences', 'view/gpc/button', 'view/common/collection',
        'interactor/word_searcher'],
(Backbone, MenuView, SidebarView, WordsView, SentencesView, GPCButtonView, CollectionView, WordSearcher) ->
  # The demo router for exploring the functionality of SynPhony.
  class DemoRouter extends Backbone.Router
    prefix = "demo"

    routes:
      "demo": "home"
      "demo/:project": "home"
      "demo/:project/words": "words"
      "demo/:project/sentences": "sentences"

    # @private
    menu: ->
      router: "demo"
      project: @project

    # @private
    sidebar: ->
      'Spelling Patterns': @makeSpellingPatterns()

    constructor: (options) ->
      super options
      @projectManager = options.projectManager
      @layout = options.layout
      @project = ""

    # Demo home route.
    home: (project) ->
      @redirect project, "words"

    # Words demo route.
    words: (project) ->
      @showContent project, "words", =>
        new WordsView { interactor: new WordSearcher { @projectManager } }

    # Sentences demo route.
    sentences: (project) ->
      @showContent project, "sentences", =>
        new SentencesView { @projectManager }

    # @private
    redirect: (project, page) ->
      @navigate "#{prefix}/#{project}/#{page}", trigger: true, replace: true

    # @private
    loadProject: (project, done) ->
      if @project != project
        @project = project
        @projectManager.setProject project
        @projectManager.load done
      else
        done()

    # @private
    makeSpellingPatterns: ->
      new CollectionView
        id: 'spelling-patterns'
        collection: @projectManager.sequences().first().elements()
        knownGPCs: @projectManager.knownGPCs()
        modelView: GPCButtonView

    # @private
    setupDefaultViews: ->
      @layout.menu.render "#{prefix}/menu/#{@project}", =>
        new MenuView model: @menu()
      @layout.sidebar.render "#{prefix}/sidebar/#{@project}", =>
        new SidebarView model: {sections: @sidebar()}

    # @private
    showContent: (project, name, viewBuilder) ->
      contentName = "#{prefix}/#{@project}/#{name}"
      console.log "Showing #{contentName}"
      @loadProject project, =>
        @setupDefaultViews()
        @layout.content.render(contentName, viewBuilder)

