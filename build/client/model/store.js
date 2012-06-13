// Generated by CoffeeScript 1.3.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  define(['collection/phonemes', 'collection/graphemes', 'collection/gpcs', 'collection/words', 'collection/sentences', 'collection/sequences', 'collection/known_gpcs', 'model/base', 'underscore'], function(Phonemes, Graphemes, GPCs, Words, Sentences, Sequences, KnownGPCs, BaseModel, _) {
    var Store;
    return Store = (function(_super) {

      __extends(Store, _super);

      Store.name = 'Store';

      Store.prototype.defaults = function() {
        var gpcs, graphemes, knownGPCs, phonemes, sentences, sequences, words;
        phonemes = new Phonemes;
        graphemes = new Graphemes;
        gpcs = new GPCs([], {
          graphemes: graphemes,
          phonemes: phonemes
        });
        words = new Words([], {
          gpcs: gpcs
        });
        sentences = new Sentences([], {
          words: words
        });
        sequences = new Sequences([], {
          gpcs: gpcs,
          words: words,
          sentences: sentences
        });
        knownGPCs = new KnownGPCs([], {
          gpcs: gpcs
        });
        return {
          phonemes: phonemes,
          graphemes: graphemes,
          gpcs: gpcs,
          words: words,
          sentences: sentences,
          sequences: sequences,
          knownGPCs: knownGPCs
        };
      };

      Store.prototype.loadOrder = function() {
        return ['phonemes', 'graphemes', 'gpcs', 'words', 'sentences', 'sequences', 'knownGPCs'];
      };

      function Store(attributes, options) {
        Store.__super__.constructor.call(this, null, options);
        if (attributes != null) {
          this.reset(attributes, options);
        }
      }

      Store.prototype.phonemes = function() {
        return this.get('phonemes');
      };

      Store.prototype.graphemes = function() {
        return this.get('graphemes');
      };

      Store.prototype.gpcs = function() {
        return this.get('gpcs');
      };

      Store.prototype.words = function() {
        return this.get('words');
      };

      Store.prototype.sentences = function() {
        return this.get('sentences');
      };

      Store.prototype.sequences = function() {
        return this.get('sequences');
      };

      Store.prototype.knownGPCs = function() {
        return this.get('knownGPCs');
      };

      Store.prototype.fetch = function(options) {
        return this.loadStack(this.loadOrder(), options);
      };

      Store.prototype.reset = function(attributes, options) {
        var _this = this;
        return _.each(this.loadOrder(), function(collection) {
          return (_this.get(collection)).reset(attributes[collection], options);
        });
      };

      Store.prototype.fetchOne = function(collection, options) {
        return collection.fetch(options);
      };

      Store.prototype.loadStack = function(stack, options) {
        var collection, myOptions,
          _this = this;
        collection = this.get(stack.shift());
        myOptions = _.clone(options);
        myOptions.success = function(collection, response) {
          if (stack.length === 0) {
            return typeof options.success === "function" ? options.success(_this, response) : void 0;
          } else {
            return _this.loadStack(stack, options);
          }
        };
        return this.fetchOne(collection, myOptions);
      };

      return Store;

    })(BaseModel);
  });

}).call(this);
