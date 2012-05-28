describe "Word", ->
  word = null
  beforeEach ->
    word = new Word name: "one"

  it "should be valid", ->
    (expect word.isValid()).toBeTruthy()

describe "Words", ->
  words = null
  [one, two, three] = [null, null, null]

  beforeEach ->
    words = new Words()
    one = new Word name: "one"
    two = new Word name: "two"
    three = new Word name: "three"
    words.reset [one, two, three]

  it "should be sorted alphabetically", ->
    (expect words.models).toEqual [one, three, two]

  it "should be valid in a collection", ->
    (expect words.models[0].isValid()).toBeTruthy()

describe "Words searching", ->
  graphemes = new Graphemes DB.graphemes, parse: true
  phonemes = new Phonemes DB.phonemes, parse: true
  gpcs = new GPCs DB.gpcs, { parse: true, graphemes, phonemes }
  words = new Words DB.words, { parse: true, gpcs }

  it "should be able to find words with target GPCs", ->