define ['collection/named', 'model/project'], (NamedCollection, Project) ->
  # Collection of projects.
  class Projects extends NamedCollection
    model: Project
    collectionUrl: 'projects'
