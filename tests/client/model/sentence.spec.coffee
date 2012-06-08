define ["model/sentence"], (Sentence) ->
  describe "Sentence", ->
    sentence = null

    beforeEach ->
      sentence = new Sentence

    it "should exist", ->
      (expect sentence).not.toBeNull()
