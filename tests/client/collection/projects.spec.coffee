define ['model/project', 'collection/projects'], (Project, Projects) ->
  describe "Projects", ->
    projects = null
    [project1, project2, project3] = [null, null, null]

    beforeEach ->
      project1 = new Project name: 'a'
      project2 = new Project name: 'b'
      project3 = new Project name: 'c'
      projects = (new Projects).reset [project1, project2, project3]

    it "should exist", ->
      (expect projects.length).toEqual 3
