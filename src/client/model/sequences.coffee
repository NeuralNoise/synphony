class Sequence extends NamedModel
  parse: (data) ->
    if data.elements?
      data.elements = new SequenceElements data.elements, {parse: true, collection: @}
    data

class Sequences extends NamedCollection
  model: Sequence
  url: '/api/v1/sequences/'

  constructor: (models, options) ->
    options ?= {}
    @sentences = options.sentences
    @words = options.words
    @gpcs = options.gpcs

    super models, options

class SequenceElement extends NamedModel
  parse: (data) ->
    @parseIdLookup 'gpcs', 'gpc', data
    @parseIdLookup 'words', 'new_words', data
    @parseIdLookup 'sentences', 'new_sentences', data
    data

class SequenceElements extends NamedCollection
  model: SequenceElement

  constructor: (models, options) ->
    options ?= {}
    @sentences = options.collection?.collection?.sentences
    @words = options.collection?.collection?.words
    @gpcs = options.collection?.collection?.gpcs

    super models, options
