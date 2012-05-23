class TemplateView extends Backbone.View
  templateData: ->
    @model?.attributes ? {}

  toHTML: ->
    Handlebars.templates[@template] @templateData()

  render: ->
    console.log "Render template"
    @$el.html @toHTML()
    @

class ToolbarView extends TemplateView
  template: "common/toolbar"

  events:
    "click .accordion": "accordion"

  accordion: (event) ->
    event.preventDefault()
    $(event.target).parent().toggleClass 'active'
    $(event.target).parent().next().toggle('fast')

  templateData: ->
    _.map @model.toolbar, (value, key) ->
      { name: key, id: value.id }

  render: ->
    super
    console.log "Rendering toolbar view "
    _.each @model.toolbar, (view) =>
      (@$ '#'+view.id).replaceWith view.render().el
    @

class PageView extends TemplateView
  menuTemplate: "common/menu"

  constructor: (options) ->
    super options

    @toolbarView = new ToolbarView model: { toolbar: @toolbar() }

  menu: ->
    'Name 1': '#one'
    'Name 2': '#two'

  toolbar: ->
    'Example': (new Backbone.View id: "id")

  menuHTML: ->
    Handlebars.templates[@menuTemplate] menu: @menu()

  render: ->
    ($ '#main-content').empty()
    ($ '#main-content').append super().el
    ($ '#main-menu').html @menuHTML()
    ($ '#toolbar-content').empty()
    ($ '#toolbar-content').append @toolbarView.render().el
    @
