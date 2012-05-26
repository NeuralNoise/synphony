# This is the store of all objects required by synphony
#
# @param [Object] phonemes test
class Store
  # document me dang it!
  phonemes: null
  graphemes: null
  gpcs: null
  words: null
  sentences: null
  sequences: null

  constructor: ->
    @phonemes = new Phonemes
    @graphemes = new Graphemes
    @gpcs = new GPCs [], { @graphemes, @phonemes }
    @words = new Words [], { @gpcs }
    @sentences = new Sentences [], { @words }
    @sequences = new Sequences [], { @gpcs, @words, @sentences }

  # Load all 
  loadAll: (callback) ->
    stack = [
      @phonemes,
      @graphemes,
      @gpcs,
      @words,
      @sentences,
      @sequences
    ]
    @loadStack stack, callback

  # @private
  fetch: (collection, callback) ->
    success = (collection, response) ->
      callback()
    error = (collection, response) ->
      callback("TODO: meaningful error here")
    collection.fetch { success, error }

  # @private
  loadStack: (stack, callback) ->
    collection = stack.shift()
    @fetch collection, (error) =>
      if error?
        callback(error)
      else if stack.length == 0
        callback()
      else
        @loadStack stack, callback

