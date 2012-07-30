define ['view/common/template', 'text!templates/gpc/button.handlebars'],
(TemplateView, hbsTemplate) ->
  # A button for a GPC.
  class GPCButtonView extends TemplateView
    template: hbsTemplate
    tagName: 'span'

    events:
      'click button': 'onClick'

    constructor: (options={}) ->
      super options
      @model = @model.gpc()
      @knownGPCs = options.knownGPCs

      @knownGPCs.on 'update', @render, @

    templateData: ->
      known: @knownGPCs.isKnown(@model)
      focus: @knownGPCs.hasFocus(@model)
      name: @model.graphemeName()

    onClick: (e) ->
      e.preventDefault()
      @knownGPCs.toggle(@model)
