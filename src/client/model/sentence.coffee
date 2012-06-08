define ['model/named'], (NamedModel) ->
  class Sentence extends NamedModel
    parse: (data) ->
      @parseIdLookup 'words', 'words', data
      data

