define ['view/common/hardpoint'], (Hardpoint) ->
  class Layout
    constructor: (hardpoints) ->
      @hardpoints = {}
      _.each hardpoints, (id, name) =>
        @hardpoints[name] = new Hardpoint el: id
        @[name] = @hardpoints[name]

    destroy: ->
      _.each @hardpoints, (hardpoint, name) =>
        hardpoint.destroy()
        delete @[name]
      @hardpoints = {}



