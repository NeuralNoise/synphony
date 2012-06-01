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
    grapheme = (@model.get 'gpc').get 'grapheme'

    active: @model.get 'active'
    focus: @model.get 'focus'
    name: grapheme.get 'name'

  onClick: (event) ->
    event.preventDefault()
    @model.toggle()


class GPCButtonsView extends Backbone.View

  constructor: (options) ->
    @userGPCs = options.collection
    @resetViews()
    # @userGPCs.on 'reset', @onGPCsReset, @
    super options

  resetViews: ->
    @collection = new UserGPCs @gpcs
    @views = @collection.map (state) ->
      new GPCButtonView model: state

  onGPCsReset: ->
    @resetViews()
    @render()

  # templateData: ->
  #   @collection.map (state) ->
  #     active: state.get 'active'
  #     focus: state.get 'focus'
  #     name: (state.get 'gpc').(get 'grapheme').get 'name'

  render: ->
    @$el.empty()
    _.each @views, (view) =>
      @$el.append view.render().el
    console.log "GPC button view rendered"
    @