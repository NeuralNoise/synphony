define ['collection/named', 'model/sequence'], (NamedCollection, Sequence) ->
  # A collection of sequences.
  class Sequences extends NamedCollection
    model: Sequence
    collectionUrl: 'sequences'

    # Create Sequences.
    # @param [Object] options
    # @option options [GPCs] gpcs The GPCs collection.
    # @option options [Words] words The words collection.
    # @option options [Sentences] sentences The sentences collection.
    constructor: (models, options) ->
      options ?= {}
      @sentences = options.sentences
      @words = options.words
      @gpcs = options.gpcs

      super models, options
