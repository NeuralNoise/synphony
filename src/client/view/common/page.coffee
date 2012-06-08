define ['jquery', 'view/common/template', 'view/common/toolbar', 'view/common/menu'],
($, TemplateView, ToolbarView, MenuView) ->
  class PageView extends TemplateView
    template: ""
    el: '#main-content'
    # menuTemplate: "common/menu"

    constructor: (options) ->
      super options

      @toolbarView = new ToolbarView model: { toolbar: @toolbar() }
      @menuView = new MenuView model: { menu: @menu() }

    menu: -> {}

    # @example
    #   {'Example': (new Backbone.View id: "id")}
    toolbar: -> {}

    # menuHTML: ->
      # Handlebars.templates[@menuTemplate] menu: @menu()

    render: ->
      super()
      @menuView.render()
      @toolbarView.render()
      @
