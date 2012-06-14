define ['underscore'], (_) ->
  # Strategy for searching through words or sentences for matches
  # with containing known GPCs and focus GPCs.
  # A known GPC is a list of GPCs that matching items MAY contain.
  # A focus GPC is a list of GPCs that matching items MUST contain.
  class KnownFocusSearch
    constructor: (collection) ->
      @models = collection.models

    getFocusItems: (focusGPCs, list = @models) ->
      _.filter list, (model) ->
        modelGPCs = model.gpcs()
        _.any modelGPCs, (modelGPC) ->
          _.any focusGPCs, (focusGPC) ->
            focusGPC.id == modelGPC.id

    getKnownItems: (knownGPCs, list = @models) ->
      _.filter list, (model) ->
        modelGPCs = model.gpcs()
        _.all modelGPCs, (modelGPC) ->
          _.any knownGPCs, (knownGPC) ->
            knownGPC.id == modelGPC.id

    getKnownFocusItems: (knownGPCs, focusGPCs, list = @models) ->
      models = @getFocusItems focusGPCs, list
      @getKnownItems knownGPCs, models