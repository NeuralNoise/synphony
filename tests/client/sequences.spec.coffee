describe "SequenceElement", ->
  element = null

  beforeEach ->
    element = new SequenceElement

  it "should exist", ->
    (expect element).not.toBeNull()

describe "SequenceElements", ->
  elements = null
  [element1, element2, element3] = [null, null, null]

  beforeEach ->
    element1 = new SequenceElement name: 'a'
    element2 = new SequenceElement name: 'b'
    element3 = new SequenceElement name: 'c'
    elements = new SequenceElements([element1, element2, element3])

  it "should exist", ->
    (expect elements.length).toEqual 3

describe "Sequence", ->
  sequence = null

  beforeEach ->
    sequence = new Sequence

  it "should exist", ->
    (expect sequence).not.toBeNull()

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
