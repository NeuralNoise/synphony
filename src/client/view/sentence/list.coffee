define ['underscore', 'view/common/base'], (_, BaseView) ->
  # A list of sentences.
  class SentenceListView extends BaseView
    tagName: 'div'
    id: 'sentence-list'

    constructor: (options) ->
      super options
      @filter = options.filter || (collection) -> collection.models
      @knownGPCs = options.knownGPCs
      @bug = false

      @knownGPCs.on 'update', @render, @

    wordHTML: (word) ->
      html = "<span class='word'>"
      if word?
        gpcs = word.gpcs()
        _.each gpcs, (gpc) =>
          html += @gpcHTML gpc
      else
        @bug = true
        html += "<span class='bug'>[NULL]</span>"
      html += "</span>"
      html

    gpcHTML: (gpc) ->
      known = ""
      known = "known" if @knownGPCs.isKnown gpc
      focus = ""
      focus = "focus" if @knownGPCs.hasFocus gpc
      "<span class='#{known} #{focus}'>#{gpc.graphemeName()}</span>"

    render: ->
      sentences = @filter(@collection)
      html = ""
      _.each sentences, (sentence) =>
        words = _.map sentence.words(), (word) => @wordHTML(word)
        html += "<p>#{words.join ' '}"
        if @bug
          @bug = false
          html += "<br /><span class='bug-info'>(#{_.escape sentence.get 'text'})</span>"
        html += "</p>"

      @$el.html html
      @
