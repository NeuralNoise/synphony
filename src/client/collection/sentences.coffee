define ['collection/named', 'model/sentence'], (NamedCollection, Sentence) ->
  class Sentences extends NamedCollection
    model: Sentence
    url: '/api/v1/sentences/'

    constructor: (models, options={}) ->
      @words = options.words

      super models, options
