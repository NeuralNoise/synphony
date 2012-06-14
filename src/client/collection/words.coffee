define ['underscore', 'collection/named', 'model/word'], (_, NamedCollection, Word) ->
  class Words extends NamedCollection
    url: '/api/v1/words/'
    model: Word
    comparator: (word) -> word.get('name')

    constructor: (models, options={}) ->
      @gpcs = options.gpcs
      super models, options

    # getFocusGPCWords: (focusGPCs, list = @models) ->
    #   _.filter list, (word) ->
    #     wordGPCs = word.get 'gpcs'
    #     _.any wordGPCs, (wordGPC) ->
    #       _.any focusGPCs, (focusGPC) ->
    #         focusGPC.id == wordGPC.id

    # getKnownGPCWords: (knownGPCs, list = @models) ->
    #   _.filter list, (word) ->
    #     wordGPCs = word.get 'gpcs'
    #     _.all wordGPCs, (wordGPC) ->
    #       _.any knownGPCs, (knownGPC) ->
    #         knownGPC.id == wordGPC.id

    # getKnownFocusGPCWords: (knownGPCs, focusGPCs, list = @models) ->
    #   words = @getFocusGPCWords focusGPCs, list
    #   @getKnownGPCWords knownGPCs, words