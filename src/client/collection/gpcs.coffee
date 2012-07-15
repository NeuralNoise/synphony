define ['collection/named', 'model/gpc'], (NamedCollection, GPC) ->
  # A collection of GPCs.
  class GPCs extends NamedCollection
    model: GPC
    collectionUrl: 'gpcs'

    # Create GPCs.
    # @param [Object] options
    # @option options [Graphemes] graphemes The graphemes collection.
    # @option options [Phonemes] phonemes The phonemes collection.
    constructor: (models, options={}) ->
      @graphemes = options.graphemes
      @phonemes = options.phonemes

      super models, options
