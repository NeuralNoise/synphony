define ['collection/named', 'model/sequence_element'], (NamedCollection, SequenceElement) ->
  class SequenceElements extends NamedCollection
    model: SequenceElement

    constructor: (models, options) ->
      options ?= {}
      @sentences = options.collection?.collection?.sentences
      @words = options.collection?.collection?.words
      @gpcs = options.collection?.collection?.gpcs

      super models, options

    getGpcs: ->
      @map (element) -> element.gpc()
