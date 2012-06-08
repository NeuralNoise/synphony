define ['view/common/template', 'text!templates/gpc/button.handlebars'],
(TemplateView, hbs_template) ->
  class GPCButtonView extends TemplateView
    template: hbs_template
    tagName: 'span'

    events:
      'click button': 'onClick'

    constructor: (options) ->
      super options

      @model.on 'change', @render, @

    templateData: ->
      grapheme = (@model.get 'gpc').get 'grapheme'

      active: @model.isKnown()
      focus: @model.hasFocus()
      name: grapheme.name()

    onClick: (event) ->
      event.preventDefault()
      @model.toggle()
