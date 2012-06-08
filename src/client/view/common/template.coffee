define ['backbone', 'handlebars', 'view/common/helpers'], (Backbone, Handlebars, helpers) ->
  # Basic view which renders a template
  class TemplateView extends Backbone.View
    template: ""

    constructor: (options = {}) ->
      super options
      @template = options.template ? @template
      @subviews = {}

    templateData: ->
      @model?.attributes ? {}

    toHTML: ->
      @compiledTemplate ?= Handlebars.compile(@template)
      @compiledTemplate @templateData()

    renderSubviews: ->
      # override

    render: ->
      @$el.html @toHTML()
      @renderSubviews()
      @
