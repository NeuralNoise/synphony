// Generated by CoffeeScript 1.3.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define([], function() {
    var KEY_DEBOUNCE_WAIT, SAVE_DEBOUNCE_WAIT, WordlistPageView, WordlistView;
    KEY_DEBOUNCE_WAIT = 400;
    SAVE_DEBOUNCE_WAIT = 1000;
    WordlistView = (function(_super) {

      __extends(WordlistView, _super);

      function WordlistView() {
        return WordlistView.__super__.constructor.apply(this, arguments);
      }

      WordlistView.prototype.template = 'segmenter/wordlist';

      WordlistView.prototype.events = {
        "keyup #wordlist": "onKeyUp",
        "click #wordlist-clean": "onClickClean",
        "click #wordlist-clean-uppercase": "onClickCleanUpperCase",
        "click #wordlist-clean-debris": "onClickCleanDebris"
      };

      WordlistView.prototype.initialize = function() {
        this.onKeyUp = _.debounce(this.onKeyUp, KEY_DEBOUNCE_WAIT);
        this.save = _.debounce(this.save, SAVE_DEBOUNCE_WAIT);
        this.model.on('change', this.onModelChange, this);
        return this.model.on('sync', this.onModelSaved, this);
      };

      WordlistView.prototype.onKeyUp = function() {
        var newValue, oldValue;
        newValue = (this.$('#wordlist')).val();
        oldValue = this.model.get('wordlist');
        this.model.set({
          wordlist: newValue
        });
        if (newValue !== oldValue) {
          return this.save();
        }
      };

      WordlistView.prototype.onModelChange = function() {
        var newValue, oldValue;
        oldValue = (this.$('#wordlist')).val();
        newValue = this.model.get('wordlist');
        (this.$('#wordlist')).val(newValue);
        if (oldValue !== newValue && oldValue !== '') {
          return this.save();
        }
      };

      WordlistView.prototype.onClickClean = function() {
        return this.model.clean();
      };

      WordlistView.prototype.onClickCleanUpperCase = function() {
        return this.model.cleanUpperCase();
      };

      WordlistView.prototype.onClickCleanDebris = function() {
        return this.model.cleanDebris();
      };

      WordlistView.prototype.save = function() {
        return this.model.save();
      };

      WordlistView.prototype.onModelSaved = function() {
        ($('#wordlist-saved')).fadeIn(50).delay(1000).fadeOut(500);
        return console.log("Wordlist saved");
      };

      return WordlistView;

    })(TemplateView);
    return WordlistPageView = (function(_super) {

      __extends(WordlistPageView, _super);

      function WordlistPageView() {
        return WordlistPageView.__super__.constructor.apply(this, arguments);
      }

      WordlistPageView.prototype.initialize = function() {
        return this.wordlistView = new WordlistView({
          model: this.model
        });
      };

      WordlistPageView.prototype.render = function() {
        ($(this.el)).append(this.wordlistView.render().el);
        return this;
      };

      return WordlistPageView;

    })(Backbone.View);
  });

}).call(this);
