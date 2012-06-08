define ['model/gpc', 'model/user_gpc'], (GPC, UserGPC) ->
  describe "UserGPC", ->
    ugpc = null

    beforeEach ->
      gpc = new GPC name: "a"
      ugpc = new UserGPC { gpc }

    it "should make a gpc known but not focused when toggled", ->
      ugpc.toggle()
      (expect ugpc.isKnown()).toBeTruthy()
      (expect ugpc.hasFocus()).toBeFalsy()

    it "should make a gpc known and focused when toggled twice", ->
      _.times 2, -> ugpc.toggle()
      (expect ugpc.isKnown()).toBeTruthy()
      (expect ugpc.hasFocus()).toBeTruthy()

    it "should make a gpc neither known nor focused when toggled thrice", ->
      _.times 3, -> ugpc.toggle()
      (expect ugpc.isKnown()).toBeFalsy()
      (expect ugpc.hasFocus()).toBeFalsy()
