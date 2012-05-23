class Segmenter
  constructor: (@words, @gpcs) ->

  segment: ->
    # graphemes = @gpcs.pluck 'grapheme'
    # graphemes = _.sortBy graphemes, (grapheme) -> (grapheme.get 'name').length
    # graphemes = graphemes.reverse()
    gpcs = @gpcs.sortBy (gpc) -> gpc.graphemeName().length
    gpcs = gpcs.reverse()

    @words.each (word) =>
      remaining = (word.get 'name').toLowerCase()
      wordGpcs = []
      while remaining != ''
        foundGpc = null
        for gpc in gpcs
          if (remaining.indexOf gpc.graphemeName()) == 0
            foundGpc = gpc
            break

        if not foundGpc
          wordGpcs = null
          break

        remaining = remaining.substring gpc.graphemeName().length

        wordGpcs.push foundGpc

      if not (word.set gpcs: wordGpcs)
        throw new Error "Invalid word!"
