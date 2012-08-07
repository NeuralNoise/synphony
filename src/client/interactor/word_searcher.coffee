define ['interactor/base', 'interactor/known_focus_search'], (BaseInteractor, KnownFocusSearch) ->
  # Searches specifically for a list of words given known GPCs.
  #
  # User story:
  # In order to build useful word lists
  # I want to be able to build a list of words containing only GPCs I know.
  class WordSearcher extends BaseInteractor
    constructor: (options) ->
      @projectManager = options.projectManager
      @words = @projectManager.words()
      @knownGPCs = @projectManager.knownGPCs()
      @search = new KnownFocusSearch @words
      @delegateEvent @knownGPCs, 'update'

    filterWords: ->
      knownGPCs = @knownGPCs.models
      focusGPCs = if @knownGPCs.isEmpty() then [] else [ @knownGPCs.last() ]
      @search.getKnownFocusItems knownGPCs, focusGPCs

    isGpcKnown: (gpc) ->
      @knownGPCs.isKnown(gpc)

    gpcHasFocus: (gpc) ->
      @knownGPCs.hasFocus(gpc)

    run: (callback) ->
      callback null, @filterWords()

    destroy: ->
      # destroy sub-interactors
      @search.destroy()
      super()
