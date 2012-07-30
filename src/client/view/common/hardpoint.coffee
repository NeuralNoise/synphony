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

    # Sets the view to a new one if the name of the new view
    # is different from the previous view's name. The viewBuilder
    # function is expected to return a new view, but will only be
    # called if the name of the current view differs.
    # @param [String] name The name of the view
    # @param [() -> new BaseView] The builder function for the view.
    setView: (name, viewBuilder) ->
      if name != @name
        if !name?
          throw new Error "Name should not be nil"
        @name = name
        if @view
          @view.destroy()
        @view = viewBuilder()
      @

    # Same as setView except the new view will be rendered and
    # replace the current contents of the hardpoint.
    # @param [String] name The name of the view
    # @param [() -> new BaseView] The builder function for the view.
    render: (name, viewBuilder) ->
      if name != @name
        @setView name, viewBuilder
        @$el.html @view.render().el

    # Destroy the hard point and any attached view.
    destroy: ->
      if @view?
        @view.destroy()
        @view = null
        @name = null
      super()
