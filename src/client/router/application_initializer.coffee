define ['jquery', 'backbone', 'view/common/layout',
        'router/admin', 'router/demo', 'router/designer',
        'interactor/cirriculum_designer',
        'interactor/project_manager'
        ],
($, Backbone, Layout, AdminRouter, DemoRouter, DesignerRouter, CirriculumDesigner, ProjectManager) ->
  # Initialize the application and start it running.
  class ApplicationInitializer
    constructor: () ->
      @adminRouter = null
      @demoRouter = null
      @designerRouter = null
      @layout = null
      @curriculumDesigner = null
      @projectManager = null

    # Initialize and start the application running.
    run: ->
      @setupLayout()
      @setupInteractors()
      @setupRouters()
      @start()

    # Setup the layout, which is the root object for the view layer.
    # @private
    setupLayout: ->
      @layout = new Layout
        menu: "#main-menu"
        content: "#main-content"
        sidebar: "#toolbar-content"

    # Setup interactors to handle the various use cases.
    # @private
    setupInteractors: ->
      @projectManager = new ProjectManager
      @curriculumDesigner = new CirriculumDesigner { @projectManager }

    # Setup the routers which handle URLs
    # @private
    setupRouters: ->
      @adminRouter = new AdminRouter { @projectManager, @layout }
      @demoRouter = new DemoRouter { @projectManager, @layout }
      @designerRouter = new DesignerRouter { @curriculumDesigner, @projectManager, @layout }

    # And set everything in motion by triggering routing of the current URL
    # @private
    start: ->
      console.log "Loaded, starting routers"
      Backbone.history.start()
