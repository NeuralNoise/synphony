describe "util", ->
  describe "hasUpperCase()", ->
    it "should detect word initial uppercase", ->
      (expect hasUpperCase "Bonus").toBeTruthy()

    it "should not describe lowercase as uppercase", ->
      (expect hasUpperCase "bonus").not.toBeTruthy()

    it "should detect word medial uppercase", ->
      (expect hasUpperCase "boNus").toBeTruthy()

