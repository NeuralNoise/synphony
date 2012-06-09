define ['underscore', 'jquery', 'view/common/template',
        'text!templates/common/sidebar.handlebars'],
(_, $, TemplateView, hbsTemplate) ->
  class SidebarView extends TemplateView
    template: hbsTemplate

    events:
      "click .accordion": "accordion"

    accordion: (event) ->
      event.preventDefault()
      parent = ($ event.target).parent()
      parent.toggleClass 'active'
      parent.next().toggle 'fast'

    templateData: ->
      _.map @model.sections, (value, key) ->
        { name: key, id: value.id }

    render: ->
      super
      console.log "Rendering sidebar view "
      _.each @model.sections, (view) =>
        (@$ '#'+view.id).replaceWith view.render().el
      @
