define ['collection/projects', 'model/project',
        'interactor/project_creator'],
(Projects, Project, ProjectCreator) ->
  describe "ProjectCreator", ->
    creator = null
    projects = null
    beforeEach ->
      projects = new Projects()
      spyOn projects, "create"
      creator = new ProjectCreator projects: projects

    it "should create a project", ->
      creator.create({})
      (expect projects.create).toHaveBeenCalledWith({})

