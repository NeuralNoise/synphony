define ['view/common/base', 'handlebars', 'view/common/helpers'],
(BaseView, Handlebars, helpers) ->
  # Basic view which renders a template
  class TemplateView extends BaseView
    template: ""

    constructor: (options = {}) ->
      super options
      @template = options.template ? @template
      @subviews = {}

    templateData: ->
      if @model?
        @model.toJSON()
      else if @collection?
        items: @collection.toJSON()

    toHTML: ->
      @compiledTemplate ?= Handlebars.compile(@template)
      @compiledTemplate @templateData()

    renderSubviews: ->
      # override

    render: ->
      @$el.html @toHTML()
      @renderSubviews()
      @
