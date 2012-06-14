// Generated by CoffeeScript 1.3.1
(function() {

  define(['model/word', 'collection/words'], function(Word, Words) {
    return describe("Words", function() {
      var one, three, two, words, _ref;
      words = null;
      _ref = [null, null, null], one = _ref[0], two = _ref[1], three = _ref[2];
      beforeEach(function() {
        words = new Words();
        one = new Word({
          name: "one"
        });
        two = new Word({
          name: "two"
        });
        three = new Word({
          name: "three"
        });
        return words.reset([one, two, three]);
      });
      it("should be sorted alphabetically", function() {
        return (expect(words.models)).toEqual([one, three, two]);
      });
      return it("should be valid in a collection", function() {
        return (expect(words.models[0].isValid())).toBeTruthy();
      });
    });
  });

}).call(this);
