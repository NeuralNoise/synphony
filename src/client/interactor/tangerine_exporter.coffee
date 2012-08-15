define ['interactor/base', 'interactor/known_focus_search'],
(BaseInteractor, KnownFocusSearcher) ->
  class TangerineExporter extends BaseInteractor
    constructor: (options) ->
      { @projectManager, @graphemesPerLesson, @wordsPerLesson, @curriculumId, @sequence } = options
      @searcher = new KnownFocusSearcher @projectManager.getWords()

    run: (done) ->
      done null, @exportJson()

    exportJson: ->
      result = []
      lessonGpcs = @lessonGpcs()
      lessonWords = @lessonWords lessonGpcs
      for gpcs, i in lessonGpcs
        words = lessonWords[i]
        result = result.concat @generateSubtests i+1, gpcs, words

      result

    generateUuid: ->
      s4 = -> return ( ( ( 1 + Math.random() ) * 0x10000 ) | 0 ).toString(16).substring(1)
      return s4()+s4()+"-"+s4()+"-"+s4()+"-"+s4()+"-"+s4()+s4()+s4()

    # @private
    lessonGpcs: ->
      result = []
      remaining = @sequence.gpcs()
      while remaining.length > 0
        result.push _.first remaining, @graphemesPerLesson
        remaining = _.rest remaining, @graphemesPerLesson
      result

    allLessonWords: (lessonGpcs) ->
      knownGpcs = []
      for focusGpcs in lessonGpcs
        knownGpcs = knownGpcs.concat focusGpcs
        @searcher.getKnownFocusItems knownGpcs, focusGpcs

    lessonWords: (lessonGpcs) ->
      sortedWords = @sortWords @allLessonWords lessonGpcs
      @trimLessonWords sortedWords, @wordsPerLesson

    sortWords: (lessonWords) ->
      _.map lessonWords, (words) =>
        words = _.sortBy words, (word) =>
          (@wordFrequency word) * 10000 + (@reversedWordLength word)
        words.reverse()

    # @private
    wordFrequency: (word) -> (word.get 'frequency') ? 0

    # @private
    reversedWordLength: (word) -> 1000 - (word.get 'name').length

    trimLessonWords: (lessonWords, length) ->
      _.map lessonWords, (words) ->
        _.first words, length

    generateSubtests: (lesson, gpcs, words) ->
      [
        (@generateSpellingPatternSubtest lesson, gpcs)
        (@generateFamiliarWordsSubtest lesson, words)
      ]

    generateSpellingPatternSubtest: (lesson, gpcs) ->
      graphemes = _.map gpcs, (gpc) -> gpc.graphemeName()

      _.extend (@subtestHeader lesson),
        variableName: 'spellingPatterns'
        name: 'Spelling Patterns'
        items: graphemes

    generateFamiliarWordsSubtest: (lesson, words) ->
      words = _.map words, (word) -> word.get 'name'

      _.extend (@subtestHeader lesson),
        variableName: 'familiarWords'
        name: 'Familiar Words'
        items: words

    subtestHeader: (lesson) ->
      collection: 'subtest'
      prototype: 'grid'
      curriculumID: @curriculumId
      lesson: lesson




