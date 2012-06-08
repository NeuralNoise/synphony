define ['model/phoneme'], (Phoneme) ->
  describe "Phoneme", ->
    phoneme = null

    beforeEach ->
      phoneme = new Phoneme

    it "should exist", ->
      (expect phoneme).not.toBeNull()
