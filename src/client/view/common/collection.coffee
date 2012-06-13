define ['underscore', 'view/common/composite', 'view/common/base'],
(_, CompositeView, BaseView) ->
  # A view that can render a collection of models with a
  # specific view.
  # Initially the element is empty until render is called
  # then once render is called, any add/remove/change events
  # on the collection will rerender.
  # Idea from Backbone.Marionette
  class CollectionView extends CompositeView
    modelView: BaseView

    constructor: (options={}) ->
      super options

      if @collection
        @collection.each (model) =>
          @addModelView model, -1, options

        @collection.on 'add', @onCollectionAdd, @
        @collection.on 'remove', @onCollectionRemove, @
        @collection.on 'reset', @onCollectionReset, @

    destroy: ->
      _.each @views, (view) -> view.destroy()
      @views = []
      super()

    makeModelView: (model, options = {}) ->
      modelView = @options.modelView || @modelView
      options = _.extend { model }, options
      view = new modelView options
      if @rendered
        view.render()
      view

    addModelView: (model, index=-1, options={}) ->
      view = @makeModelView model, options
      @addView view, index

    removeModelView: (model) ->
      views = _.select @views, (view) -> view.model.cid == model.cid
      _.each views, (view) -> @removeView view

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

