define ['underscore', 'jquery', 'view/common/template',
        'text!templates/common/sidebar.handlebars'],
(_, $, TemplateView, hbsTemplate) ->
  # A sidebar view.
  class SidebarView extends TemplateView
    template: hbsTemplate

    events:
      "click .accordion": "accordion"

    # @private
    accordion: (event) ->
      event.preventDefault()
      parent = ($ event.target).parent()
      parent.toggleClass 'active'
      parent.next().toggle 'fast'

    # @private
    templateData: ->
      _.map @model.sections, (value, key) ->
        { name: key, id: value.id }

    render: ->
      super
      console.log "Rendering sidebar view "
      _.each @model.sections, (view) =>
        (@$ '#'+view.id).replaceWith view.render().el
      @
