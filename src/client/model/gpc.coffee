define ['model/named'], (NamedModel) ->
  # Grapheme Phoneme Correspondence. This is a spelling pattern to
  # make a certain sound in the language.
  class GPC extends NamedModel
    constructor: (attributes, options) ->
      # _.bindAll @, 'graphemeName'
      super attributes, options

    # Get the grapheme name.
    # @return [String] The grapheme name.
    graphemeName: ->
      grapheme = @get 'grapheme'
      if grapheme?
        grapheme.get 'name'
      else
        null

    # @private
    parse: (data) ->
      @parseIdLookup 'graphemes', 'grapheme', data
      @parseIdLookup 'phonemes', 'phoneme', data
      data

