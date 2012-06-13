define ['model/gpc', 'collection/known_gpcs'], (GPC, KnownGPCs) ->
  describe "KnownGPCs", ->
    knowns = null
    [gpc1, gpc2, gpc3] = [null, null, null]

    beforeEach ->
      gpc1 = new GPC name: 'a_a'
      gpc2 = new GPC name: 'b_b'
      gpc3 = new GPC name: 'c_c'
      knowns = (new KnownGPCs).reset [gpc1, gpc2, gpc3]

    it "should have isKnown method", ->
      unknown = new GPC name: 'd_d'
      (expect knowns.isKnown gpc1).toBeTruthy()
      (expect knowns.isKnown unknown).toBeFalsy()

    it "should have hasFocus method", ->
      (expect knowns.hasFocus gpc2).toBeFalsy()
      (expect knowns.hasFocus gpc3).toBeTruthy()

    it "should toggle known", ->
      (expect knowns.isKnown gpc3).toBeTruthy()
      knowns.toggle gpc3
      (expect knowns.isKnown gpc3).toBeFalsy()
