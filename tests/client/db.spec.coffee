if window.DB?
  describe "DB", ->
    graphemes = new Graphemes DB.graphemes, parse: true
    phonemes = new Phonemes DB.phonemes, parse: true
    gpcs = new GPCs DB.gpcs, { parse: true, graphemes, phonemes }
    words = new Words DB.words, { parse: true, gpcs }
    sentences = new Sentences DB.sentences, { parse: true, words }
    sequences = new Sequences DB.sequences, { parse: true, sentences, words, gpcs }

    describe "graphemes", ->
      it "should load", ->
        (expect graphemes.getByName 'a').not.toBeNull()

    describe "phonemes", ->
      it "should load", ->
        (expect phonemes.getByName 'a').not.toBeNull()

    describe "GPCs", ->
      it "should load", ->
        (expect gpcs.getByName 'a_a').not.toBeNull()

      it "should associate grapheme id to graphemes", ->
        gpc = gpcs.getByName 'a_a'
        grapheme = gpc.get 'grapheme'
        (expect grapheme instanceof Grapheme).toBeTruthy()

      it "should associate phoneme id to phonemes", ->
        gpc = gpcs.getByName 'a_a'
        phoneme = gpc.get 'phoneme'
        (expect phoneme instanceof Phoneme).toBeTruthy()

    describe "words", ->
      it "should load", ->
        (expect words.getByName 'ambao').not.toBeNull()

      it "should associate gpc ids to gpcs", ->
        ambao = words.getByName 'ambao'
        ambaoGpcs = ambao.get 'gpcs'
        gpc = _.first ambaoGpcs
        (expect gpc.get 'name').toEqual 'a_a'

    describe "sentences", ->
      it "should load", ->
        (expect sentences.getByName 'Warumi 16:24').not.toBeNull()

      it "should associate word ids to words", ->
        sentence = sentences.getByName 'Warumi 16:24'
        word = _.first sentence.get 'words'
        (expect word instanceof Word).toBeTruthy()

    describe "sequences", ->
      sequence = null
      elements = null

      beforeEach ->
        sequence = sequences.getByName 'Productivity Sequence'
        elements = sequence.get 'elements'

      it "should load", ->
        (expect sequence).not.toBeNull()

      it "should contain a collection of SequenceElements", ->
        (expect elements instanceof SequenceElements).toBeTruthy()

      describe "elements", ->
        element = null

        beforeEach ->
          element = elements.last()

        it "should associate gpc ids to gpcs", ->
          gpc = element.get 'gpc'
          (expect gpc instanceof GPC).toBeTruthy()

        it "should associate word ids to words", ->
          word = _.first element.get 'new_words'
          (expect word instanceof Word).toBeTruthy()

        it "should associate sentence ids to sentences", ->
          sentence = _.first element.get 'new_sentences'
          (expect sentence instanceof Sentence).toBeTruthy()


