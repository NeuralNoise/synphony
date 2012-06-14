define ['underscore', 'view/common/base'], (_, BaseView) ->
  class SentenceListView extends BaseView
    tagName: 'div'
    id: 'sentence-list'

    constructor: (options) ->
      super options
      @filter = options.filter || (collection) -> collection.models
      @knownGPCs = options.knownGPCs

      @knownGPCs.on 'update', @render, @

    # wordHTML: (word) ->
    #   html = "<span class='word'>"
    #   gpcs = word.gpcs()
    #   _.each gpcs, (gpc) =>
    #     html += @gpcHTML gpc
    #   html += "</span>"
    #   html

    # gpcHTML: (gpc) ->
    #   known = ""
    #   known = "known" if @knownGPCs.isKnown gpc
    #   focus = ""
    #   focus = "focus" if @knownGPCs.hasFocus gpc
    #   "<span class='#{known} #{focus}'>#{gpc.graphemeName()}</span>"

    render: ->
      sentences = @filter(@collection)
      html = ""
      _.each sentences, (sentence) =>
        # console.log word.name()
        text = sentence.get 'text'
        html += "<p>"+text+"</p>"

      @$el.html html
      @
