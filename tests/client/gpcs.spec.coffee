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
