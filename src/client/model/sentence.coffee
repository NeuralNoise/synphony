define ['underscore', 'model/named'], (_, NamedModel) ->
  # Sentence is a list of words, and has the proper formatting too.
  class Sentence extends NamedModel
    # Get a set of GPCs in the sentence. Duplicates are
    # removed.
    # @return [Array<GPC>] the set of gpcs.
    gpcs: ->
      @cachedGPCs ?= @findGPCs()

    # Get the list of words in the sentence.
    # @return [Array<Word>] words
    words: -> @get 'words'

    # @private
    parse: (data) ->
      @parseIdLookup 'words', 'words', data
      data

    # @private
    findGPCs: ->
      words = @get 'words'
      gpcs = _.collect words, (word) -> word?.gpcs()
      gpcs = _.flatten gpcs
      gpcs = _.compact gpcs
      _.unique gpcs


