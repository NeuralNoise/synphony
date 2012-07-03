define ['collection/named', 'model/gpc'], (NamedCollection, GPC) ->
  class GPCs extends NamedCollection
    model: GPC
    collectionUrl: 'gpcs'

    constructor: (models, options={}) ->
      @graphemes = options.graphemes
      @phonemes = options.phonemes

      super models, options
