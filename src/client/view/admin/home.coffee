define ['view/common/template', 'text!templates/admin/home_page.handlebars'],
(TemplateView, hbsTemplate) ->
  class AdminHomeView extends TemplateView
    template: hbsTemplate
