define ['model/sequence', 'collection/sequences'], (Sequence, Sequences) ->
  describe "Sequences", ->
    sequences = null
    [sequence1, sequence2, sequence3] = [null, null, null]

    beforeEach ->
      sequence1 = new Sequence name: 'a'
      sequence2 = new Sequence name: 'b'
      sequence3 = new Sequence name: 'c'
      sequences = new Sequences([sequence1, sequence2, sequence3])

    it "should exist", ->
      (expect sequences.length).toEqual 3
