define ['underscore', 'view/common/base'], (_, BaseView) ->
  class WordListView extends BaseView
    tagName: 'table'
    id: 'word-list'

    constructor: (options) ->
      super options
      @filter = options.filter || (collection) -> collection.models
      @userGPCs = options.userGPCs
      @columns = options.columns || 3

      @userGPCs.on 'change', @render, @

    wordHTML: (word) ->
      html = "<span class='word'>"
      ugpcs = @userGPCs.mapGPCs word.gpcs()
      _.each ugpcs, (ugpc) =>
        html += @userGpcHTML ugpc
      html += "</span>"
      html

    userGpcHTML: (ugpc) ->
      known = ""
      known = "known" if ugpc.isKnown()
      focus = ""
      focus = "focus" if ugpc.hasFocus()
      "<span class='#{known} #{focus}'>#{ugpc.graphemeName()}</span>"

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
