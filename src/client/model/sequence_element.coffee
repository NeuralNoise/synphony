define ['model/named'], (NamedModel) ->
  # This is one element of the seqence.
  class SequenceElement extends NamedModel
    # Get the GPC that represents the element.
    # @return GPC the GPC
    gpc: -> @get 'gpc'

    # @private
    parse: (data) ->
      @parseIdLookup 'gpcs', 'gpc', data
      @parseIdLookup 'words', 'new_words', data
      @parseIdLookup 'sentences', 'new_sentences', data
      data
