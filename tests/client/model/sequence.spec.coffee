define ['model/sequence'], (Sequence) ->
  describe "Sequence", ->
    sequence = null

    beforeEach ->
      sequence = new Sequence

    it "should exist", ->
      (expect sequence).not.toBeNull()
