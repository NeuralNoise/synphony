define ['interactor/base', 'model/store'], (BaseInteractor, Store) ->
  # Manages projects and allows them to be switched and a new one to be loaded.
  #
  # Eventually the Store model will be replaced by this class, since what
  # the Store does is more of an interactor responsibility.
  #
  # User story:
  # In order to work on multiple language projects
  # I want to be able to load different projects.
  class ProjectManager extends BaseInteractor
    constructor: (data) ->
      if data?
        @store = new Store data, parse: true
      else
        @store = new Store
      @project = @store.project

    getStore: -> @store

    # Get the phonemes collection
    # @return [Phonemes] phonemes
    getPhonemes: -> @store.phonemes()

    # @depricated
    phonemes: -> @getPhonemes()

    # Get the graphemes collection
    # @return [Graphemes] graphemes
    getGraphemes: -> @store.graphemes()

    # @depricated
    graphemes: -> @getGraphemes()

    # Get the gpcs collection
    # @return [GPCs] gpcs
    getGpcs: -> @store.gpcs()

    # @depricated
    gpcs: -> @getGpcs()

    # Get the words collection
    # @return [Words] words
    getWords: -> @store.words()

    # @depricated
    words: -> @getWords()

    # Get the sentences collection
    # @return [Sentences] sentences
    getSentences: -> @store.sentences()

    # @depricated
    sentences: -> @getSentences()

    # Get the sequences collection
    # @return [Sequences] sequences
    getSequences: -> @store.sequences()

    # @depricated
    sequences: -> @getSequences()

    # Get the knownGPCs collection
    # @return [KnownGPCs] knownGPCs
    getKnownGPCs: -> @store.knownGPCs()

    # @depricated
    knownGPCs: -> @getKnownGPCs()

    setProject: (name) ->
      @store.setProject(name)
      @project = @store.project

    load: (done) ->
      @store.fetch { success: done }
