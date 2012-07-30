define ['underscore', 'view/common/base'], (_, BaseView) ->
  # A view composed of a list of sub-views. Initially not
  # rendered to HTML but once it is rendered, adding a view
  # will render it and insert it into the HTML.
  # Idea from Backbone.Marionette
  class CompositeView extends BaseView
    constructor: (options={}) ->
      super options

      @views = []

      @rendered = false

    # Destroy all sub-views and ourself.
    destroy: ->
      _.each @views, (view) -> view.destroy()
      @views = []
      super()

    # Add a view. If already rendered the new view
    # will be rendered and inserted into the DOM.
    # @param [BaseView] view The view to add.
    # @param [int] index The index to insert at. -1 is the end.
    addView: (view, index=-1) ->
      if index < 0 || index >= @views.length
        @views.push view
        if @rendered
          @$el.append view.el
      else
        @views.splice index, 0, view
        if @rendered
          @$el.children()[index].insertBefore view.el

    # Remove a specific view. The view will be destroyed.
    # @param [BaseView] view The view to remove.
    removeView: (view) ->
      index = @views.indexOf view
      if index >= 0
        @views.splice index, 1
        view.destroy()
      else
        throw new Error "View not found"

    # Render the view and all sub-views. After this method
    # is called, any modifications to the list of sub-views
    # will be displayed.
    render: ->
      if @rendered
        _.each @views, (view) -> view.remove()
      @rendered = true
      _.each @views, (view) =>
        @$el.append view.render().el
      console.log "rendered composite/collection"
      @
