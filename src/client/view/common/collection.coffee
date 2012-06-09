define ['underscore', 'view/common/base'],
(_, BaseView) ->
  # A view that can render a collection of models with a
  # specific view.
  # Initially the element is empty until render is called
  # then once render is called, any add/remove/change events
  # on the collection will rerender.
  # Idea from Backbone.Marionette
  class CollectionView extends BaseView
    modelView: BaseView

    constructor: (options={}) ->
      super options

      @views = []

      @rendered = false

      if @collection
        @collection.each (model) =>
          @addModelView model

        @collection.on 'add', @onCollectionAdd, @
        @collection.on 'remove', @onCollectionRemove, @
        @collection.on 'reset', @onCollectionReset, @

    destroy: ->
      _.each @views, (view) -> view.destroy()
      @views = []
      super()

    makeModelView: (model, options = {}) ->
      modelView = @options.modelView || @modelView
      options = _.extend options, { model }
      view = new modelView options
      if @rendered
        view.render()
      view

    addView: (view, index=-1) ->
      if index < 0 || index >= @views.length
        @views.push view
        if @rendered
          @$el.append view.el
      else
        @views.splice index, 0, view
        if @rendered
          @$el.children()[index].insertBefore view.el

    removeView: (view) ->
      index = @views.indexOf view
      if index >= 0
        @views.splice index, 1
        view.destroy()
      else
        throw new Error "View isn't in ViewCollection"

    addModelView: (model, index=-1, options={}) ->
      view = @makeModelView model, options
      @addView view, index

    removeModelView: (model) ->
      views = _.select @views, (view) -> view.model.cid == model.cid
      _.each views, (view) -> @removeView view

    render: ->
      if @rendered
        _.each @views, (view) -> view.remove()
      @rendered = true
      _.each @views, (view) =>
        @$el.append view.render().el
      console.log "collection rendered"
      @

    # @private
    onCollectionAdd: (model) ->
      index = @collection.indexOf model
      @addModelView model, index

    # @private
    onCollectionRemove: (model) ->
      @removeModelView model

    # @private
    onCollectionReset: ->
      _.each @views, (view) -> view.destroy()
      @views = []
      @collection.each (model) =>
        @addModelView model

