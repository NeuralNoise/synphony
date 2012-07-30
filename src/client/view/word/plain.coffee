define ['view/common/template', 'text!templates/word/plain.handlebars'],
(TemplateView, hbsTemplate) ->
  # Currently not used.
  class PlainWordView extends TemplateView
    template: 'words/plain_word'
    tagName: 'span'
    tagClass: 'word'
