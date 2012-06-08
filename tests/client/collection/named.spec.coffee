define ['model/named', 'collection/named'], (NamedModel, NamedCollection) ->
  describe "NamedCollection", ->
    collection = null
    [one, two, three] = [null, null, null]

    beforeEach ->
      collection = new NamedCollection
      one = new NamedModel name: "one"
      two = new NamedModel name: "two"
      three = new NamedModel name: "three"
      collection.reset [one, two, three]

    it "should be able to quickly find a model by name", ->
      (expect collection.getByName 'one').toEqual one

    it "should be valid in a collection", ->
      (expect one.isValid()).toBeTruthy()

    it "should return undefined if a name is not in the collection", ->
      (expect collection.getByName 'random').toBeNull()
