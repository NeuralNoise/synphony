class Sentence extends NamedModel
  parse: (data) ->
    @parseIdLookup 'words', 'words', data
    data

class Sentences extends NamedCollection
  model: Sentence
  url: '/api/v1/sentences/'

  constructor: (models, options) ->
    options ?= {}
    @words = options.words

    super models, options
