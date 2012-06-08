// Generated by CoffeeScript 1.3.1
(function() {

  define(['model/grapheme', 'collection/graphemes'], function(Grapheme, Graphemes) {
    return describe("Graphemes", function() {
      var graph1, graph2, graph3, graphs, _ref;
      graphs = null;
      _ref = [null, null, null], graph1 = _ref[0], graph2 = _ref[1], graph3 = _ref[2];
      beforeEach(function() {
        graph1 = new Grapheme({
          name: 'a'
        });
        graph2 = new Grapheme({
          name: 'b'
        });
        graph3 = new Grapheme({
          name: 'c'
        });
        return graphs = (new Graphemes).reset([graph1, graph2, graph3]);
      });
      return it("should exist", function() {
        return (expect(graphs.length)).toEqual(3);
      });
    });
  });

}).call(this);
