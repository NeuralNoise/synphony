define ['model/named', 'collection/named'], (NamedModel, NamedCollection) ->
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
