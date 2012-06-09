define ['view/common/template', 'text!templates/common/menu.handlebars'],
(TemplateView, hbsTemplate) ->
  class MenuView extends TemplateView
    template: hbsTemplate
    tagName: 'span'

    templateData: -> @model