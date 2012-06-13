define ['model/named'], (NamedModel) ->
  class SequenceElement extends NamedModel
    gpc: -> @get 'gpc'

    parse: (data) ->
      @parseIdLookup 'gpcs', 'gpc', data
      @parseIdLookup 'words', 'new_words', data
      @parseIdLookup 'sentences', 'new_sentences', data
      data
