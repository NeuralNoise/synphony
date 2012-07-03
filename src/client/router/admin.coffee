define ['backbone', 'view/common/menu', 'view/common/template',
        'view/common/hider', 'view/common/collection',
        'text!templates/admin/home.handlebars'],
(Backbone, MenuView, TemplateView, HiderView, CollectionView, homeTemplate) ->
  class AdminRouter extends Backbone.Router
    routes:
      "": "home"

    menu: -> {}

    constructor: (options) ->
      super options
      @store = options.store
      @layout = options.layout

    home: ->
      @showContent 'home', ->
        new TemplateView template: homeTemplate

    redirect: (page) ->
      @navigate page, trigger: true, replace: true

    # @private
    setupDefaultViews: ->
      @layout.menu.render "admin/menu", =>
        new MenuView model: { menu: @menu() }
      @layout.sidebar.render "admin/sidebar", =>
        new HiderView selector: "#side-panel, #side-panel-toggle"

    # @private
    showContent: (name, viewBuilder) ->
      contentName = "admin/#{name}"
      console.log "Showing #{contentName}"
      @setupDefaultViews()
      @layout.content.render contentName, viewBuilder
