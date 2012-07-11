define ['backbone'], (Backbone) ->
  # Collection of BaseModels -- currently no extra code here but
  # may in the future contain some.
  #
  # @abstract
  # @see http://backbonejs.org/#Collection Backbone.Collection
  class BaseCollection extends Backbone.Collection
    project: "synphony"

    url: () ->
      "/api/v1/#{@project}/#{@collectionUrl}/"

    add: (models, options={}) ->
      super models, options
      @trigger 'update', @ if not options.silent

    remove: (models, options={}) ->
      super models, options
      @trigger 'update', @ if not options.silent

    reset: (models, options={}) ->
      super models, options
      @trigger 'update', @ if not options.silent
