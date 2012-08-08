define ['model/project'], (Project) ->
  describe "Project", ->
    project = null

    beforeEach ->
      project = new Project

    it "should exist", ->
      (expect project).not.toBeNull()
