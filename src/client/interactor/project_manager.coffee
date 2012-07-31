define ['interactor/base', 'model/store'], (BaseInteractor, Store) ->
  # In order to multitask I want to be able to load different projects.
  class ProjectManager extends BaseInteractor
    constructor: ->
      @store = new Store
      @project = @store.project

    getStore: -> @store

    # Get the phonemes collection
    # @return [Phonemes] phonemes
    phonemes: -> @store.phonemes()

    # Get the graphemes collection
    # @return [Graphemes] graphemes
    graphemes: -> @store.graphemes()

    # Get the gpcs collection
    # @return [GPCs] gpcs
    gpcs: -> @store.gpcs()

    # Get the words collection
    # @return [Words] words
    words: -> @store.words()

    # Get the sentences collection
    # @return [Sentences] sentences
    sentences: -> @store.sentences()

    # Get the sequences collection
    # @return [Sequences] sequences
    sequences: -> @store.sequences()

    # Get the knownGPCs collection
    # @return [KnownGPCs] knownGPCs
    knownGPCs: -> @store.knownGPCs()

    setProject: (name) -> 
      @store.setProject(name)
      @project = @store.project

    load: (done) ->
      @store.fetch { success: done }
