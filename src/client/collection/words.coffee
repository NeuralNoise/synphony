define ['underscore', 'collection/named', 'model/word'], (_, NamedCollection, Word) ->
  # A collection of words.
  class Words extends NamedCollection
    model: Word
    collectionUrl: 'words'

    # Sort words alphabetically.
    comparator: (word) -> word.get('name')

    # Create Words.
    # @param [Object] options
    # @option options [GPCs] gpcs The GPCs collection.
    constructor: (models, options={}) ->
      @gpcs = options.gpcs
      super models, options
