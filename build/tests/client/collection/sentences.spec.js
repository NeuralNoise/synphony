// Generated by CoffeeScript 1.3.1
(function() {

  define(['model/sentence', 'collection/sentences'], function(Sentence, Sentences) {
    return describe("Sentences", function() {
      var sentence1, sentence2, sentence3, sentences, _ref;
      sentences = null;
      _ref = [null, null, null], sentence1 = _ref[0], sentence2 = _ref[1], sentence3 = _ref[2];
      beforeEach(function() {
        sentence1 = new Sentence({
          name: 'a'
        });
        sentence2 = new Sentence({
          name: 'b'
        });
        sentence3 = new Sentence({
          name: 'c'
        });
        return sentences = new Sentences([sentence1, sentence2, sentence3]);
      });
      return it("should exist", function() {
        return (expect(sentences.length)).toEqual(3);
      });
    });
  });

}).call(this);
