describe "Segmenter", ->
  segmenter = null
  words = null
  [gpca, gpcb, gpcbb, gpcc] = [null, null, null, null]
  gpcs = null

  beforeEach ->
    words = (new Words).reset [
      new Word name: 'abba'
      new Word name: 'bac'
      new Word name: 'cab'
    ]

    gpca = new GPC grapheme: (new Grapheme name: 'a'), phoneme: (new Phoneme name: 'a')
    gpcbb = new GPC grapheme: (new Grapheme name: 'bb'), phoneme: (new Phoneme name: 'b')
    gpcb = new GPC grapheme: (new Grapheme name: 'b'), phoneme: (new Phoneme name: 'b')
    gpcc = new GPC grapheme: (new Grapheme name: 'c'), phoneme: (new Phoneme name: 'c')

    gpcs = (new GPCs).reset [ gpca, gpcb, gpcbb, gpcc ]
    segmenter = new Segmenter words, gpcs

  it "should segment abba", ->
    segmenter.segment()
    abba = words.getByName 'abba'
    (expect abba.get 'gpcs').toEqual [gpca, gpcbb, gpca]
