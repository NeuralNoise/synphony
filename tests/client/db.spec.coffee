define ['model/store', 'model/grapheme', 'model/phoneme', 'model/word',
        'collection/sequence_elements', 'model/gpc', 'model/sentence'],
(Store, Grapheme, Phoneme, Word, SequenceElements, GPC, Sentence) ->
  describe "DB", ->
    store = new Store DB, parse: true
    graphemes = store.graphemes()
    phonemes = store.phonemes()
    gpcs = store.gpcs()
    words = store.words()
    sentences = store.sentences()
    sequences = store.sequences()

    describe "graphemes", ->
      it "should load", ->
        (expect graphemes.getByName 'a').not.toBeNull()

    describe "phonemes", ->
      it "should load", ->
        (expect phonemes.getByName 'a').not.toBeNull()

    describe "GPCs", ->
      it "should load", ->
        (expect gpcs.getByName 's_s').not.toBeNull()

      it "should associate grapheme id to graphemes", ->
        gpc = gpcs.getByName 's_s'
        console.log gpc.attributes
        grapheme = gpc.get 'grapheme'
        (expect grapheme instanceof Grapheme).toBeTruthy()

      it "should associate phoneme id to phonemes", ->
        gpc = gpcs.getByName 's_s'
        phoneme = gpc.get 'phoneme'
        (expect phoneme instanceof Phoneme).toBeTruthy()

    describe "words", ->
      it "should load", ->
        (expect words.getByName 'long').not.toBeNull()

      it "should associate gpc ids to gpcs", ->
        long = words.getByName 'long'
        longGpcs = long.get 'gpcs'
        gpc = _.first longGpcs
        (expect gpc.get 'name').toEqual 'l_l'

    describe "sentences", ->
      it "should load", ->
        (expect sentences.getByName 'Jhn 3:16').not.toBeNull()

      it "should associate word ids to words", ->
        sentence = sentences.getByName 'Jhn 3:16'
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


