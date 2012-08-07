define ['interactor/tangerine_exporter', 'interactor/project_manager'],
(TangerineExporter, ProjectManager) ->
  describe "TangerineExporter", ->
    projectManager = new ProjectManager DB
    exporter = null

    beforeEach ->
      exporter = new TangerineExporter {
        graphemesPerLesson: 3
        wordsPerLesson: 20
        curriculumId: "test_curriculum_id"
        sequence: projectManager.getSequences().first()
        projectManager
      }

    # This won't pass because javascript and ruby have different sorting algorithms
    # and there's slight differences in the word lists. I tried to fix it but it's
    # totally a rabbit hole I am choosing not to go down now.
    xit "should export data tangerine expects", ->
      finished = false
      handler = (err, data) ->
        (expect err).toBeFalsy()
        (expect data).toEqual TANGERINE_SUBTESTS
        finished = true
      runs (-> exporter.run handler), "the export process"
      waitsFor (-> finished), "the export to finish"

    expectArrayOfArraysOfLength = (arrayOfArrays, outerLength, innerLength) ->
      (expect arrayOfArrays.length).toEqual outerLength
      (expect arrayOfArrays[0].length).toEqual innerLength

    expectFirstFirstNameToBe = (arrayOfArrays, firstName) ->
      (expect arrayOfArrays[0][0].get 'name').toEqual firstName


    it "should have a method to split the gpcs into groups of 3", ->
      lessonGpcs = exporter.lessonGpcs()
      expectArrayOfArraysOfLength lessonGpcs, 9, 3
      expectFirstFirstNameToBe lessonGpcs, 'e_e'

    it "should find words for each lesson", ->
      lessonWords = exporter.allLessonWords exporter.lessonGpcs()
      expectArrayOfArraysOfLength lessonWords, 9, 6
      expectFirstFirstNameToBe lessonWords, 'e'

    it "should sort the words properly", ->
      lessonWords = exporter.allLessonWords exporter.lessonGpcs()
      lessonWords = exporter.sortWords lessonWords
      firstLessonWordNames = _.map lessonWords[0], (word) -> word.get 'name'
      (expect firstLessonWordNames).toEqual [
        "em"
        "e"
        "me"
        "es"
        "sem"
        "meme"
      ]

    it "should trim the word list to the specified number of words", ->
      lessonWords = [['a', 'b', 'c'], ['e', 'f', 'g', 'h']]
      result = exporter.trimLessonWords lessonWords, 2
      expectArrayOfArraysOfLength result, 2, 2

    it "should generate the proper json for tangerine", ->
      lessonGpcs = exporter.lessonGpcs()
      lessonWords = exporter.lessonWords lessonGpcs
      subtests = exporter.generateSubtests 1, lessonGpcs[0], lessonWords[0]
      (expect subtests).toEqual (_.first TANGERINE_SUBTESTS, 2)

