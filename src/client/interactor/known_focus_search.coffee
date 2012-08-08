define ['underscore', 'interactor/base'], (_, BaseInteractor) ->
  # Strategy for searching through words or sentences for matches
  # with containing known GPCs and focus GPCs.
  # A known GPC is a list of GPCs that matching items MAY contain.
  # A focus GPC is a list of GPCs that matching items MUST contain.
  #
  # The Item refered to below is *any* object with a .gpcs() method that
  # returns an Array of GPC instances. So this will work on Word or Sentence
  # instances, and in the future perhaps Story instances too.
  #
  # User Story:
  # In order to build useful teaching material
  # I want to be able to filter any list of items containing a list of GPCs by
  # which GPCs are known and which are the focus of the lesson.
  class KnownFocusSearch extends BaseInteractor
    # Create the search.
    # @param [Backbone.Collection] collection optional collection of items
    constructor: (collection) ->
      @models = collection?.models

    # Get the list of items that have the known and focus GPCs.
    # This algorithm works on any item with a gpcs() method that
    # returns an array of gpcs. The result is a subset of the list
    # which contains no unknown gpcs, and contains any focus gpcs.
    # @param [Array<GPC>] knownGPCs array of known GPC instances
    # @param [Array<GPC>] focusGPCs array of focus GPC instances
    # @param [Array<Item>] list array of items with .gpcs() method (optional - defaults to collection's models)
    # @return [Array<Item>] list of items found
    getKnownFocusItems: (knownGPCs, focusGPCs, list = @models) ->
      models = @getFocusItems focusGPCs, list
      @getKnownItems knownGPCs, models

    run: (knownGPCs, focusGPCs, list = @models, callback) ->
      callback null, @getKnownFocusItems knownGPCs, focusGPCs, list

    # @private
    # This filters the list for items that contain at least one of the focus
    # GPCs.
    getFocusItems: (focusGPCs, list = @models) ->
      _.filter list, (model) ->
        modelGPCs = model.gpcs()
        _.any modelGPCs, (modelGPC) ->
          _.any focusGPCs, (focusGPC) ->
            focusGPC.id == modelGPC.id

    # @private
    # This filters out any items that have unknown GPCs.
    getKnownItems: (knownGPCs, list = @models) ->
      _.filter list, (model) ->
        modelGPCs = model.gpcs()
        _.all modelGPCs, (modelGPC) ->
          _.any knownGPCs, (knownGPC) ->
            knownGPC.id == modelGPC.id
