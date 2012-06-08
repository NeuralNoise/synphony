define ['model/gpc', 'model/phoneme', 'model/grapheme'], (GPC, Phoneme, Grapheme) ->
  describe "GPC", ->
    gpc = null
    graph = null
    phone = null

    beforeEach ->
      graph = new Grapheme name: 'a'
      phone = new Phoneme name: 'b'
      gpc = new GPC grapheme: graph, phoneme: phone

    it "should have graphemeName to get grapheme name", ->
      (expect gpc.graphemeName()).toEqual 'a'
