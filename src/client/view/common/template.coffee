define ['view/common/base', 'handlebars', 'view/common/helpers'],
(BaseView, Handlebars, helpers) ->
  # Basic view which renders a template
  class TemplateView extends BaseView
    # The template to show.
    template: ""

    # Can pass template in the options here as well.
    constructor: (options = {}) ->
      super options
      @template = options.template ? @template
      @subviews = {}

    # The data for the template. By default it calls toJSON()
    # on the model or collection.
    # @private
    templateData: ->
      if @model?
        @model.toJSON()
      else if @collection?
        items: @collection.toJSON()

    # Produce the HTML.
    toHTML: ->
      @compiledTemplate ?= Handlebars.compile(@template)
      @compiledTemplate @templateData()

    # Hook to render any subviews in the proper place.
    renderSubviews: ->
      # override

    # Render the template.
    render: ->
      @$el.html @toHTML()
      @renderSubviews()
      @
