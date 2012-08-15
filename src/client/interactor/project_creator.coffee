define ['collection/projects', 'model/project', 'interactor/base'],
(Projects, Project, InteractorBase) ->
  class ProjectCreator extends InteractorBase
    constructor: (options) ->
      @projects = options.projects

    create: (value) ->
      @projects.create value