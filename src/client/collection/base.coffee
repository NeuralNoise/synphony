define ['backbone'], (Backbone) ->
  # Collection of BaseModels -- currently no extra code here but
  # may in the future contain some.
  #
  # @abstract
  # @see http://backbonejs.org/#Collection Backbone.Collection
  class BaseCollection extends Backbone.Collection
    # Not sure what this is doing here.... -Ryan
    project: "synphony"

    # @private
    url: () ->
      "/api/v1/#{@project}/#{@collectionUrl}/"

    # Add a model to the collection.
    # Also fires the update event in addition to the usual add event
    add: (models, options={}) ->
      super models, options
      @trigger 'update', @ if not options.silent

    # Remove a model from the collection.
    # Also fires the update event in addition to the usual remove event
    remove: (models, options={}) ->
      super models, options
      @trigger 'update', @ if not options.silent

    # Replace the models in the collection with another list of models.
    # Also fires the update event in addition to the usual reset event
    reset: (models, options={}) ->
      super models, options
      @trigger 'update', @ if not options.silent
