// Generated by CoffeeScript 1.3.1
(function() {
  var SegmenterRouter,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  SegmenterRouter = (function(_super) {

    __extends(SegmenterRouter, _super);

    SegmenterRouter.name = 'SegmenterRouter';

    function SegmenterRouter() {
      return SegmenterRouter.__super__.constructor.apply(this, arguments);
    }

    SegmenterRouter.prototype.routes = {
      "": "wordlist"
    };

    SegmenterRouter.prototype.wordlist = function() {
      var wordlist, wordlistPageView;
      wordlist = new Wordlist;
      wordlist.fetch();
      wordlistPageView = new WordlistPageView({
        model: wordlist
      });
      ($('#main')).empty();
      return ($('#main')).append(wordlistPageView.render().el);
    };

    return SegmenterRouter;

  })(Backbone.Router);

}).call(this);
