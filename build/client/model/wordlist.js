// Generated by CoffeeScript 1.3.1
(function() {
  var DEBRIS, HYPHEN_APOSTROPHE, WHITESPACE, Wordlist,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  WHITESPACE = /[\u0009\u000A\u000B\u000C\u000D\u0020\u0085\u00A0\u1680\u180E\u2000\u2001\u2002\u2003\u2004\u2005\u2006\u2007\u2008\u2009\u200A\u2028\u2029\u202F\u205F\u3000]+/;

  DEBRIS = new XRegExp("[\\p{P}\\p{Sm}\\p{Sc}\\p{So}\\p{N}]", "g");

  HYPHEN_APOSTROPHE = "'`-\u2018\u2019\u2010";

  Wordlist = (function(_super) {

    __extends(Wordlist, _super);

    Wordlist.name = 'Wordlist';

    function Wordlist() {
      return Wordlist.__super__.constructor.apply(this, arguments);
    }

    Wordlist.prototype.url = '/api/v1/wordlist/1';

    Wordlist.prototype.defaults = {
      id: 1
    };

    Wordlist.prototype.initialize = function() {};

    Wordlist.prototype.toList = function() {
      var words;
      words = (this.get('wordlist')).split(WHITESPACE);
      words = _.unique(words);
      return _.reject(words, function(word) {
        return word === '';
      });
    };

    Wordlist.prototype.clean = function() {
      return this.fromArray(this.toList().sort());
    };

    Wordlist.prototype.fromArray = function(ary) {
      return this.set({
        wordlist: ary.join('\n')
      });
    };

    Wordlist.prototype.cleanUpperCase = function() {
      var list;
      list = this.toList();
      list = _.reject(list, function(word) {
        return hasUpperCase(word) && _.include(list, word.toLowerCase());
      });
      return this.fromArray(list);
    };

    Wordlist.prototype.cleanDebris = function() {
      var wordlist;
      wordlist = XRegExp.replace(this.get('wordlist'), DEBRIS, function(match) {
        if (HYPHEN_APOSTROPHE.indexOf(match[0]) >= 0) {
          return match[0];
        } else {
          return '';
        }
      });
      this.set({
        wordlist: wordlist
      });
      return this.clean();
    };

    Wordlist.prototype.resetWords = function(words) {
      var list;
      list = _.map(this.toList(), function(word) {
        return {
          name: word
        };
      });
      return words.reset(list);
    };

    return Wordlist;

  })(Backbone.Model);

}).call(this);
