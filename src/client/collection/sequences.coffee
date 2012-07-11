define ['collection/named', 'model/sequence'], (NamedCollection, Sequence) ->
  class Sequences extends NamedCollection
    model: Sequence
    collectionUrl: 'sequences'

    constructor: (models, options) ->
      options ?= {}
      @sentences = options.sentences
      @words = options.words
      @gpcs = options.gpcs

      super models, options
