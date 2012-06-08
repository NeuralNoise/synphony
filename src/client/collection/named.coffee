define ['collection/base'], (BaseCollection) ->

  # Collection of NamedModels.
  #
  # @abstract
  # @see http://backbonejs.org/#Collection Backbone.Collection
  class NamedCollection extends BaseCollection
    # Fetch a model by its name. This will index the names of the
    # models the first time it's called, then afterwards this
    # method should be fast.
    #
    # @param [String] name Name of the model to look up.
    # @returns [NamedModel] model looked up or null if not found.
    getByName: (name) ->
      if not @_byName?
        @_byName = {}
        for model in @models
          if model.attributes?.name?
            @_byName[model.attributes.name] = model
      @_byName[name] || null

    # @see http://backbonejs.org/#Collection-add Backbone.Collection#add
    add: (models, options) ->
      @_byName = null
      super(models, options)

    # @see http://backbonejs.org/#Collection-remove Backbone.Collection#remove
    remove: (models, options) ->
      @_byName = null
      super(models, options)
