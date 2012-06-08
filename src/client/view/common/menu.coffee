define ['view/common/template', 'text!templates/common/menu.handlebars'],
(TemplateView, hbs_template) ->
  class MenuView extends TemplateView
    template: hbs_template
    el: '#main-menu'

    templateData: -> @model