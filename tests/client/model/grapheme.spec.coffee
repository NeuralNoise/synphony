define ["model/grapheme"], (Grapheme) ->
  describe "Grapheme", ->
    grapheme = null

    beforeEach ->
      grapheme = new Grapheme

    it "should exist", ->
      (expect grapheme).not.toBeNull()
