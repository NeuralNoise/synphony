define ['underscore', 'model/named'], (_, NamedModel) ->
  class Sentence extends NamedModel
    parse: (data) ->
      @parseIdLookup 'words', 'words', data
      data

    gpcs: ->
      @cachedGPCs ?= @findGPCs()

    # @private
    findGPCs: ->
      words = @get 'words'
      gpcs = _.collect words, (word) -> word?.gpcs()
      gpcs = _.flatten gpcs
      gpcs = _.compact gpcs
      _.unique gpcs


