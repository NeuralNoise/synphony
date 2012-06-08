define ['underscore', 'backbone', 'collection/user_gpcs', 'view/gpc/button'],
(_, Backbone, UserGPCs, GPCButtonView) ->
  class GPCButtonsView extends Backbone.View

    constructor: (options) ->
      super options
      @resetViews()
      @collection.on 'reset', @onGPCsReset, @

    resetViews: ->
      console.log "reset gpc buttons view views:", @collection.length
      @views = @collection.map (ugpc) ->
        new GPCButtonView model: ugpc

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
        console.log view.model.name()
        @$el.append view.render().el
      console.log "GPC button view rendered"
      @
