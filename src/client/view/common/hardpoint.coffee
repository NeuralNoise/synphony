define ['view/common/base'], (BaseView) ->
  # A part of the page where views are commonly attached.
  # The attachment is usually from a router. This will
  # ensure previous views are destroyed properly when a new
  # view is set.
  # Idea from Backbone.Marionette Region
  class Hardpoint extends BaseView
    constructor: (options) ->
      super options
      @view = null

    setView: (view) ->
      if @view
        @view.destroy()
      @view = view
      @

    render: (view = null) ->
      if view
        @setView view
      @$el.html @view.render().el

    destroy: ->
      @view.destroy()
      @view = null
      super()
