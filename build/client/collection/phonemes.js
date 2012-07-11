// Generated by CoffeeScript 1.3.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  define(['collection/named', 'model/phoneme'], function(NamedCollection, Phoneme) {
    var Phonemes;
    return Phonemes = (function(_super) {

      __extends(Phonemes, _super);

      Phonemes.name = 'Phonemes';

      function Phonemes() {
        return Phonemes.__super__.constructor.apply(this, arguments);
      }

      Phonemes.prototype.model = Phoneme;

      Phonemes.prototype.collectionUrl = 'phonemes';

      return Phonemes;

    })(NamedCollection);
  });

}).call(this);
