# Models with a name and some validations for that name. Also
# has some code to help with translating id numbers into
# references while parsing.
#
# @abstract
# @see http://backbonejs.org/#Model Backbone.Model
class NamedModel extends Backbone.Model
  # Construct new NamedModel
  #
  # @param [Object] attributes Initial attributes of the model
  # @param [Object] options Options
  # @option options [NamedCollection] collection model's colleciton
  #
  # @see http://backbonejs.org/#Model-constructor Backbone.Model#constructor
  constructor: (attributes, options = {}) ->
    @collection = options.collection
    super attributes, options

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

  # Helper for parse() to convert id numbers into object references in a
  # more delarative way. Works on arrays of ids too.
  #
  # @param collectionName [String] name of the collection property of this
  #   model's collection
  # @param fieldName [String] name of the property in data to look up the
  #   id for
  # @param data [Object] the data to change ids to references in
  parseIdLookup: (collectionName, fieldName, data) ->
    if @collection? and @collection[collectionName]?
      if data[fieldName] instanceof Array and typeof (_.first data[fieldName]) is "number"
        # array of ids
        data[fieldName] = _.map data[fieldName], (id) =>
          item = @collection[collectionName].get(id)
          item ? id
      else if typeof data[fieldName] is "number"
        item = @collection[collectionName].get(data[fieldName])
        data[fieldName] = item ? data[fieldName]

# Collection of NamedModels.
#
# @abstract
# @see http://backbonejs.org/#Collection Backbone.Collection
class NamedCollection extends Backbone.Collection
  # Fetch a model by its name. This will index the names of the
  # models the first time it's called, then afterwards this
  # method should be fast.
  #
  # @param [String] name Name of the model to look up.
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
