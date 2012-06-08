define ['model/gpc', 'collection/gpcs'], (GPC, GPCs) ->
  describe "GPCs", ->
    gpcs = null
    [gpc1, gpc2, gpc3] = [null, null, null]

    beforeEach ->
      gpc1 = new GPC name: 'a_a'
      gpc2 = new GPC name: 'b_b'
      gpc3 = new GPC name: 'c_c'
      gpcs = (new GPCs).reset [gpc1, gpc2, gpc3]

    it "should exist", ->
      (expect gpcs.length).toEqual 3
