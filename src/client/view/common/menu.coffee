define ['view/common/template', 'text!templates/common/menu.handlebars'],
(TemplateView, hbsTemplate) ->
  # A basic menu view.
  class MenuView extends TemplateView
    template: hbsTemplate
    tagName: 'span'

    templateData: -> @model