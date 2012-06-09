define ['view/common/template', 'text!templates/admin/sentences_page.handlebars'],
(TemplateView, hbsTemplate) ->
  class AdminSentencesView extends TemplateView
    template: hbsTemplate
