define ['model/named'], (NamedModel) ->
  class GPC extends NamedModel
    constructor: (attributes, options) ->
      # _.bindAll @, 'graphemeName'
      super attributes, options

    graphemeName: ->
      grapheme = @get 'grapheme'
      if grapheme?
        grapheme.get 'name'
      else
        null

    parse: (data) ->
      @parseIdLookup 'graphemes', 'grapheme', data
      @parseIdLookup 'phonemes', 'phoneme', data
      data

