define ["model/sequence_element", "collection/sequence_elements"], (SequenceElement, SequenceElements) ->
  describe "SequenceElements", ->
    elements = null
    [element1, element2, element3] = [null, null, null]

    beforeEach ->
      element1 = new SequenceElement name: 'a'
      element2 = new SequenceElement name: 'b'
      element3 = new SequenceElement name: 'c'
      elements = new SequenceElements([element1, element2, element3])

    it "should exist", ->
      (expect elements.length).toEqual 3
