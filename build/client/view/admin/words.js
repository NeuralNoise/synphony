// Generated by CoffeeScript 1.3.1
(function() {
  var AdminWordsPageView,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  AdminWordsPageView = (function(_super) {

    __extends(AdminWordsPageView, _super);

    AdminWordsPageView.name = 'AdminWordsPageView';

    AdminWordsPageView.prototype.template = 'admin/words_page';

    function AdminWordsPageView(options) {
      AdminWordsPageView.__super__.constructor.call(this, options);
      this.collection = this.store.words;
      this.wordsView = new WordsListView({
        collection: this.collection
      });
    }

    AdminWordsPageView.prototype.render = function() {
      AdminWordsPageView.__super__.render.call(this);
      ($('#words-list')).empty();
      ($('#words-list')).append(this.wordsView.render().el);
      return this;
    };

    return AdminWordsPageView;

  })(AdminPageView);

}).call(this);
