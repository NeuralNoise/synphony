define ['model/gpc', 'collection/gpcs', 'collection/user_gpcs'], (GPC, GPCs, UserGPCs) ->
  describe "UserGPCs", ->
    ugpcs = null
    gpcs = null

    beforeEach ->
      gpcs = _.map ['a', 'b', 'c'], (name) -> new GPC { name }
      coll = new GPCs gpcs
      ugpcs = new UserGPCs [], gpcs: coll

    it "should return a list of known GPCs", ->
      ugpcs.first().toggle()
      (expect ugpcs.getKnownGPCs()).toEqual([gpcs[0]])

    it "should return a list of focus GPCs", ->
      ugpcs.last().toggle()
      ugpcs.last().toggle()
      (expect ugpcs.getFocusGPCs()).toEqual([gpcs[2]])