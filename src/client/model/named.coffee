define ['underscore', 'model/base'], (_, BaseModel) ->
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
    # @private
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
