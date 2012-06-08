define ['model/word'], (Word) ->
  describe "Word", ->
    word = null
    beforeEach ->
      word = new Word name: "one"

    it "should be valid", ->
      (expect word.isValid()).toBeTruthy()
