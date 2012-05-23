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

describe "GPCState", ->
  state = null

  beforeEach ->
    gpc = new GPC name: "a"
    state = new GPCState { gpc }

  it "should make a gpc active but not focused when toggled", ->
    state.toggle()
    (expect state.get 'active').toBeTruthy()
    (expect state.get 'focus').toBeFalsy()

  it "should make a gpc active and focused when toggled twice", ->
    _.times 2, -> state.toggle()
    (expect state.get 'active').toBeTruthy()
    (expect state.get 'focus').toBeTruthy()

  it "should make a gpc neither active nor focused when toggled thrice", ->
    _.times 3, -> state.toggle()
    (expect state.get 'active').toBeFalsy()
    (expect state.get 'focus').toBeFalsy()

describe "GPCStates", ->
  states = null

  beforeEach ->
    gpcs = _.map ['a', 'b', 'c'], (name) -> new GPC { name }
    states = new GPCStates gpcs
