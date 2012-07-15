define ['collection/named', 'model/sequence_element'], (NamedCollection, SequenceElement) ->
  # A nested collection inside the Sequence model. This probably should be
  # refactored into a flat structure so it's easier to work with instead of
  # being nested.
  class SequenceElements extends NamedCollection
    model: SequenceElement

    # Create Sentences.
    # @param [Object] options
    # @option options [GPCs] gpcs The GPCs collection.
    # @option options [Words] words The words collection.
    # @option options [Sentences] sentences The sentences collection.
    constructor: (models, options) ->
      options ?= {}
      @sentences = options.collection?.collection?.sentences
      @words = options.collection?.collection?.words
      @gpcs = options.collection?.collection?.gpcs

      super models, options

    # Get a list of gpcs.
    # @return [Array] A list of gpcs.
    getGpcs: ->
      @map (element) -> element.gpc()
