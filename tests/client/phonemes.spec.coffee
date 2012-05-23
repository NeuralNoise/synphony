describe "Phoneme", ->
  phoneme = null

  beforeEach ->
    phoneme = new Phoneme

  it "should exist", ->
    (expect phoneme).not.toBeNull()

describe "Phonemes", ->
  phones = null
  [phone1, phone2, phone3] = [null, null, null]

  beforeEach ->
    phone1 = new Phoneme name: 'a'
    phone2 = new Phoneme name: 'b'
    phone3 = new Phoneme name: 'c'
    phones = (new Phonemes).reset [phone1, phone2, phone3]

  it "should exist", ->
    (expect phones.length).toEqual 3
