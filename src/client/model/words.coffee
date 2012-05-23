class Word extends NamedModel

  parse: (data) ->
    @parseIdLookup 'gpcs', 'gpcs', data
    data

class Words extends NamedCollection
  url: '/api/v1/words/'
  model: Word
  comparator: (word) -> word.get('name')

  constructor: (models, options) ->
    options ?= {}
    @gpcs = options.gpcs
    super models, options

