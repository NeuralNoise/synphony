define ['model/sequence', 'collection/sequence_elements'], (Sequence, SequenceElements) ->
  describe "Sequence", ->
    sequence = null

    beforeEach ->
      elements = new SequenceElements [{gpc: '1'}, {gpc: '2'}]
      sequence = new Sequence { elements }

    it "should exist", ->
      gpcs = sequence.gpcs()
      sgpcs = sequence.elements().getGpcs()
      (expect gpcs).toEqual sgpcs
