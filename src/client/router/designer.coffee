define ['backbone', 'view/common/layout', 'view/common/menu',
        'view/common/collection'],
(Backbone, Layout, MenuView, CollectionView) ->
  class DesignerRouter extends Backbone.Router
    prefix = "designer"

    routes:
      "designer/:project": "home"

    menu: -> {}
     # "Words": "##{prefix}/#{@project}/words"
     # "Sentences": "##{prefix}/#{@project}/sentences"

    #sidebar: ->
    #  'Spelling Patterns': @makeSpellingPatterns()

    constructor: (options) ->
      super options
      @store = options.store
      @layout = options.layout
      @project = ""

    home: (project) ->
      @showContent project, "home", =>
        new TeachingOrderView { @store }

    # @private
    redirect: (project, page) ->
      @navigate "#{prefix}/#{project}/#{page}", trigger: true, replace: true

    # @private
    loadProject: (project, done) ->
      if @project != project
        @project = project
        @store.setProject project
        @store.fetch success: done
      else
        done()

    # @private
    setupDefaultViews: ->
      @layout.menu.render "#{prefix}/menu/#{@project}", =>
        new MenuView model: { menu: @menu() }
      @layout.sidebar.render "designer/sidebar", =>
        new HiderView selector: "#side-panel, #side-panel-toggle"

    # @private
    showContent: (project, name, viewBuilder) ->
      contentName = "#{prefix}/#{@project}/#{name}"
      console.log "Showing #{contentName}"
      @loadProject project, =>
        @setupDefaultViews()
        @layout.content.render(contentName, viewBuilder)

