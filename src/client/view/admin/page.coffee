define ['view/common/page', 'view/gpc/buttons'], (PageView, GPCButtonsView) ->
  class AdminPageView extends PageView
    toolbar: ->
      'Spelling Patterns': (new GPCButtonsView
        collection: @store.userGPCs()
        id: "spelling-patterns")

    menu: ->
      'Home': '#'
      'Words': '#words'
      'Sentences': '#sentences'

    constructor: (options) ->
      @store = options.store

      super options
