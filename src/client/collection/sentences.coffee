define ['collection/named', 'model/sentence'], (NamedCollection, Sentence) ->
  # Collection of sentences.
  class Sentences extends NamedCollection
    model: Sentence
    collectionUrl: 'sentences'

    # Create Sentences.
    # @param [Object] options
    # @option options [Words] words The words collection.
    constructor: (models, options={}) ->
      @words = options.words

      super models, options
