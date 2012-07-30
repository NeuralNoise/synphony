define ['jquery', 'backbone', 'model/store', 'view/common/layout',
        'router/admin', 'router/demo', 'router/designer', 'interactor/cirriculum_designer'
        ],
($, Backbone, Store, Layout, AdminRouter, DemoRouter, DesignerRouter, CirriculumDesigner) ->
  # Initialize the application and start it running.
  class ApplicationInitializer
    constructor: () ->
      @adminRouter = null
      @demoRouter = null
      @designerRouter = null
      @layout = null
      @store = null
      @curriculumDesigner = null

    # Initialize and start the application running.
    run: ->
      @setupLayout()
      @setupStore()
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

    # Setup the store, which is the root object for the model layer.
    # @private
    setupStore: ->
      @store = new Store

    # Setup interactors to handle the various use cases.
    # @private
    setupInteractors: ->
      @curriculumDesigner = new CirriculumDesigner { @store, @layout }

    # Setup the routers which handle URLs
    # @private
    setupRouters: ->
      @adminRouter = new AdminRouter { @store, @layout }
      @demoRouter = new DemoRouter { @store, @layout }
      @designerRouter = new DesignerRouter { @curriculumDesigner }

    # And set everything in motion by triggering routing of the current URL
    # @private
    start: ->
      console.log "Loaded, starting routers"
      Backbone.history.start()
