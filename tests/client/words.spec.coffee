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



