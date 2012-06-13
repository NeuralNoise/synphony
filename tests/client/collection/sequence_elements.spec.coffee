define ["model/sequence_element", "collection/sequence_elements"], (SequenceElement, SequenceElements) ->
  describe "SequenceElements", ->
    elements = null
    [element1, element2, element3] = [null, null, null]

    beforeEach ->
      element1 = new SequenceElement name: 'a', gpc: 'a_a'
      element2 = new SequenceElement name: 'b', gpc: 'b_b'
      element3 = new SequenceElement name: 'c', gpc: 'c_c'
      elements = new SequenceElements([element1, element2, element3])

    it "should exist", ->
      (expect elements.length).toEqual 3

    it "should list gpcs", ->
      (expect elements.getGpcs()).toEqual ['a_a', 'b_b', 'c_c']
