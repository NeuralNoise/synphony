define ['model/sequence_element'], (SequenceElement) ->
  describe "SequenceElement", ->
    element = null

    beforeEach ->
      element = new SequenceElement

    it "should exist", ->
      (expect element).not.toBeNull()
