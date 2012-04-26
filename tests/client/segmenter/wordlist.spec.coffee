describe "Wordlist", ->
  wordlist = null
  beforeEach ->
    wordlist = new Wordlist()

  describe "toList()", ->
    it "should get a list of words", ->
      wordlist.set wordlist: "one two three"
      (expect wordlist.toList()).toEqual ["one", "two", "three"]

    it "should not have duplicates", ->
      wordlist.set wordlist: "one two one three"
      (expect wordlist.toList()).toEqual ["one", "two", "three"]

    it "should clean the word list when asked", ->
      wordlist.set wordlist: "one \ntwo\t one  \n\n  three\n\n\n"
      wordlist.clean()
      (expect wordlist.get('wordlist')).toEqual "one\ntwo\nthree"
