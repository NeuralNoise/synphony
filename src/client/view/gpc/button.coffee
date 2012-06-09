define ['view/common/template', 'text!templates/gpc/button.handlebars'],
(TemplateView, hbsTemplate) ->
  class GPCButtonView extends TemplateView
    template: hbsTemplate
    tagName: 'span'

    events:
      'click button': 'onClick'

    constructor: (options) ->
      super options

      @model.on 'change', @render, @

    templateData: ->
      known: @model.isKnown()
      focus: @model.hasFocus()
      name: @model.graphemeName()

    onClick: (event) ->
      event.preventDefault()
      @model.toggle()
