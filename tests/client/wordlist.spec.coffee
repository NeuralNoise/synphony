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
      (expect wordlist.get 'wordlist').toEqual "one\nthree\ntwo"

    it "should clean uppercase when asked", ->
      wordlist.set wordlist: "One three Two one thrEE"
      wordlist.cleanUpperCase()
      (expect wordlist.get 'wordlist').toEqual "three\nTwo\none"

    it "should clean debris when asked", ->
      wordlist.set wordlist: "one. tw`o, three-four 1 2 3 & % $ f've"
      wordlist.cleanDebris()
      (expect wordlist.get 'wordlist').toEqual "f've\none\nthree-four\ntw`o"

    it "should be able to reset Words with a new set of Word objects", ->
      words = new Words
      wordlist.set wordlist: "one two three"
      wordlist.resetWords words
      (expect (words.where name: "two").length).toEqual 1

