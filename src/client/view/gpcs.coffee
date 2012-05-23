class GPCButtonView extends TemplateView
  template: 'gpcs/button'
  tagName: 'span'

  events:
    'click button': 'onClick'

  constructor: (options) ->
    super options

    @model.on 'change', @render, @

  templateData: ->
    console.log "get data"
    active: @model.get 'active'
    focus: @model.get 'focus'
    name: (@model.get 'gpc').get 'name'

  onClick: (event) ->
    event.preventDefault()
    @model.toggle()


class GPCButtonsView extends Backbone.View

  constructor: (options) ->
    @gpcs = options.collection
    @resetViews()
    @gpcs.on 'reset', @onGPCsReset, @
    super options

  resetViews: ->
    @collection = new GPCStates @gpcs
    @views = @collection.map (state) ->
      new GPCButtonView model: state

  onGPCsReset: ->
    @resetViews()
    @render()

  templateData: ->
    @collection.map (state) ->
      active: state.get 'active'
      focus: state.get 'focus'
      name: (state.get 'gpc').get 'name'

  render: ->
    @$el.empty()
    _.each @views, (view) =>
      @$el.append view.render().el
    console.log "GPC button view rendered"
    @