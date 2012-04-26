class TemplateView extends Backbone.View
  toHTML: ->
    Handlebars.templates[@template] @model.toJSON()

  render: ->
    console.log "Render template"
    ($ @el).html @toHTML()
    @
