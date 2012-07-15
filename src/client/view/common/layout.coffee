define ['view/common/hardpoint'], (Hardpoint) ->
  # A colleciton of hardpoints. The names of the hardpoints will
  # be available as attributes of the class.
  class Layout
    # Takes a name:selector object with the names and jquery selectors
    # for each hardpoint on the page. The names will become attributes
    # of this object for easy access.
    # @param [Object] hardpoints The name:selector pairs.
    constructor: (hardpoints) ->
      @hardpoints = {}
      _.each hardpoints, (id, name) =>
        @hardpoints[name] = new Hardpoint el: id
        @[name] = @hardpoints[name]

    # Destroy all the hardpoints.
    destroy: ->
      _.each @hardpoints, (hardpoint, name) =>
        hardpoint.destroy()
        delete @[name]
      @hardpoints = {}



