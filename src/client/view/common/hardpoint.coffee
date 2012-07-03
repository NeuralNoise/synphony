define ['view/common/base'], (BaseView) ->
  # A part of the page where views are commonly attached.
  # The attachment is usually from a router. This will
  # ensure previous views are destroyed properly when a new
  # view is set. The name is used to determine if the
  # view should be built or not. If the same name is passed
  # in then the view will not be built.
  # Idea from Backbone.Marionette Region
  class Hardpoint extends BaseView
    constructor: (options) ->
      super options
      @view = null
      @name = null

    setView: (name, viewBuilder) ->
      if name != @name
        if !name?
          throw new Error "Name should not be nil"
        @name = name
        if @view
          @view.destroy()
        @view = viewBuilder()
      @

    render: (name, viewBuilder) ->
      if name != @name
        @setView name, viewBuilder
        @$el.html @view.render().el

    destroy: ->
      @view.destroy()
      @view = null
      super()
