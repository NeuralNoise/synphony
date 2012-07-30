define ['model/named'], (NamedModel) ->
  # A word in the language.
  class Word extends NamedModel
    # Get the list of gpcs.
    # @return [Array<GPC>] the list of gpcs in the language
    gpcs: -> @get 'gpcs'

    # Get the name of the word.
    # @return [String] The name, which is the text of the word.
    name: -> @get 'name'

    # @private
    parse: (data) ->
      @parseIdLookup 'gpcs', 'gpcs', data
      data
