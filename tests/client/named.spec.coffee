describe "NamedModel", ->
  model = null

  beforeEach ->
    model = new NamedModel

  it "should valid only with a name", ->
    (expect model.isValid()).not.toBeTruthy()
    model.set name: "one"
    (expect model.isValid()).toBeTruthy()

  it "should not allow two models with the same name", ->
    coll = new NamedCollection
    item1 = new NamedModel name: "one"
    item2 = new NamedModel name: "one"
    coll.add item1
    coll.add item2
    (expect item2.isValid()).toBeFalsy()

  it "should allow setting attributes", ->
    model.set name: "one"
    (expect model.set something: ["two", "three", "four"]).toBeTruthy()


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
