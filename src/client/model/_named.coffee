# Models with a name and some validations for that name.
#
# @abstract
class NamedModel extends BaseModel
  # Get the name.
  #
  # @returns [String] name the name of the model
  name: -> @get 'name'

  # Basic validation of the name
  #
  # @see http://backbonejs.org/#Model-validate Backbone.Model#validate
  validate: (attribs) ->
    if not attribs.name?
      "Must have a name"
    else if @collection?
      modelsWithMyName = @collection.where name: attribs.name
      if _.isEmpty modelsWithMyName
        null
      else if modelsWithMyName.length > 1 or (_.first modelsWithMyName) != @
        "Model with name #{attribs.name} already exists"
    else
      null

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
