define ['interactor/base', 'interactor/known_focus_search'], (BaseInteractor, KnownFocusSearch) ->
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
