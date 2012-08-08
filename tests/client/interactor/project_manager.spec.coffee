define ['interactor/tangerine_exporter', 'interactor/project_manager'],
(TangerineExporter, ProjectManager) ->
  describe "TangerineExporter", ->
    projectManager = null

    beforeEach ->
      projectManager = new ProjectManager DB

    it "should get a list of projects", ->
      projectManager.getProjects()