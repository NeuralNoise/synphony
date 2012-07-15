define ['underscore', 'view/common/base'], (_, BaseView) ->
  # A list of words. For speed, a template is not used. Instead a string is built
  # and given to jquery in one go.
  class WordListView extends BaseView
    tagName: 'table'
    id: 'word-list'

    constructor: (options) ->
      super options
      @filter = options.filter || (collection) -> collection.models
      @knownGPCs = options.knownGPCs
      @columns = options.columns || 3

      @knownGPCs.on 'update', @render, @

    wordHTML: (word) ->
      html = "<span class='word'>"
      gpcs = word.gpcs()
      _.each gpcs, (gpc) =>
        html += @gpcHTML gpc
      html += "</span>"
      html

    gpcHTML: (gpc) ->
      known = ""
      known = "known" if @knownGPCs.isKnown gpc
      focus = ""
      focus = "focus" if @knownGPCs.hasFocus gpc
      "<span class='#{known} #{focus}'>#{gpc.graphemeName()}</span>"

    render: ->
      words = @filter(@collection)
      column = 0
      html = "<tr>"
      _.each words, (word) =>
        # console.log word.name()
        html += "<td>"+@wordHTML(word)+"</td>"
        column += 1
        if column >= @columns
          column = 0
          html += "</tr><tr>"

      @$el.html html
      @
