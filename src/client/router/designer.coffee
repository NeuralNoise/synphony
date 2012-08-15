define ['backbone', 'view/common/layout', 'view/common/menu', 'view/common/hider'
        'view/common/collection', 'view/designer/exporter', 'interactor/tangerine_exporter'],
(Backbone, Layout, MenuView, HiderView, CollectionView, ExporterView, TangerineExporter) ->
  # Cirriculum designer interface, for building lesson plans and assessments.
  class DesignerRouter extends Backbone.Router
    prefix = "designer"

    routes:
      "designer/:project": "home"
      "designer/:project/export": "export"

    # @private
    menu: ->
      router: "demo"
      project: @project

    #sidebar: ->
    #  'Spelling Patterns': @makeSpellingPatterns()

    constructor: (options) ->
      super options
      @projectManager = options.projectManager
      @layout = options.layout
      @project = ""

    # Designer home.
    home: (project) ->
      @showContent project, "home", =>
        new TeachingOrderView { @projectManager }

    export: (project) ->
      @showContent project, "export", =>
        exporter = new TangerineExporter {
          graphemesPerLesson: 3
          wordsPerLesson: 20
          curriculumId: "curriculum-example-tok_pisin"
          sequence: @projectManager.getSequences().first()
          @projectManager
        }
        new ExporterView interactor: exporter

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

