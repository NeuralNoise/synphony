define ['collection/phonemes', 'collection/graphemes', 'collection/gpcs',
        'collection/words', 'collection/sentences', 'collection/sequences',
        'collection/user_gpcs', 'model/base', 'underscore'],
(Phonemes, Graphemes, GPCs, Words, Sentences, Sequences, UserGPCs, BaseModel, _) ->
  # This is the store of all collections required by synphony. The
  # primary responsibility of this class is to ensure collections
  # are loaded in the proper order so that dependancies are met.
  class Store extends BaseModel
    # This is the default structure of collections and also
    # the default attributes of this model.
    # @private
    defaults: ->
      phonemes = new Phonemes
      graphemes = new Graphemes
      gpcs = new GPCs [], { graphemes, phonemes }
      words = new Words [], { gpcs }
      sentences = new Sentences [], { words }
      sequences = new Sequences [], { gpcs, words, sentences }
      userGPCs = new UserGPCs [], { gpcs }

      { phonemes, graphemes, gpcs, words, sentences, sequences, userGPCs }

    # This is the load order of each collection
    # @private
    loadOrder: ->
      [
        'phonemes'
        'graphemes'
        'gpcs'
        'words'
        'sentences'
        'sequences'
        # 'userGPCs'
      ]

    constructor: (attributes, options) ->
      super null, options
      if attributes?
        @reset attributes, options

    # Get the phonemes collection
    # @returns [Phonemes] phonemes
    phonemes: -> @get 'phonemes'

    # Get the graphemes collection
    # @returns [Graphemes] graphemes
    graphemes: -> @get 'graphemes'

    # Get the gpcs collection
    # @returns [GPCs] gpcs
    gpcs: -> @get 'gpcs'

    # Get the words collection
    # @returns [Words] words
    words: -> @get 'words'

    # Get the sentences collection
    # @returns [Sentences] sentences
    sentences: -> @get 'sentences'

    # Get the sequences collection
    # @returns [Sequences] sequences
    sequences: -> @get 'sequences'

    # Get the userGPCs collection
    # @returns [UserGPCs] userGPCs
    userGPCs: -> @get 'userGPCs'

    # Fetches each collection individually in the
    # proper order.
    fetch: (options) ->
      @loadStack @loadOrder(), options

    # Take one `Object` with all collections and reset each
    # collection in the proper order.
    reset: (attributes, options) ->
      _.each @loadOrder(), (collection) =>
        (@get collection).reset attributes[collection], options

    # @private
    fetchOne: (collection, options) ->
      collection.fetch options

    # @private
    loadStack: (stack, options) ->
      collection = @get stack.shift()
      myOptions = _.clone options
      myOptions.success = (collection, response) =>
        if stack.length == 0
          options.success?(@, response)
        else
          @loadStack stack, options
      @fetchOne collection, myOptions
