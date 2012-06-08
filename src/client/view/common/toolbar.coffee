define ['underscore', 'jquery', 'view/common/template',
        'text!templates/common/toolbar.handlebars'],
(_, $, TemplateView, hbs_template) ->
  class ToolbarView extends TemplateView
    template: hbs_template
    el: '#toolbar-content'

    events:
      "click .accordion": "accordion"

    accordion: (event) ->
      event.preventDefault()
      parent = ($ event.target).parent()
      parent.toggleClass 'active'
      parent.next().toggle 'fast'

    templateData: ->
      _.map @model.toolbar, (value, key) ->
        { name: key, id: value.id }

    render: ->
      super
      console.log "Rendering toolbar view "
      _.each @model.toolbar, (view) =>
        (@$ '#'+view.id).replaceWith view.render().el
      @
