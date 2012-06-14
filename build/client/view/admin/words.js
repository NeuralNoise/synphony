// Generated by CoffeeScript 1.3.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  define(['view/common/template', 'view/common/composite', 'view/common/collection', 'view/word/list', 'model/known_focus_search', 'text!templates/admin/words_page.handlebars'], function(TemplateView, CompositeView, CollectionView, WordListView, KnownFocusSearch, hbsTemplate) {
    var AdminWordsView;
    return AdminWordsView = (function(_super) {

      __extends(AdminWordsView, _super);

      AdminWordsView.name = 'AdminWordsView';

      AdminWordsView.prototype.id = 'words-page';

      function AdminWordsView(options) {
        var _this = this;
        AdminWordsView.__super__.constructor.call(this, options);
        this.store = options.store;
        this.collection = this.store.words();
        this.knownGPCs = this.store.knownGPCs();
        this.search = new KnownFocusSearch(this.collection);
        this.addView(new TemplateView({
          template: hbsTemplate
        }));
        this.addView(new WordListView({
          collection: this.collection,
          knownGPCs: this.knownGPCs,
          filter: function() {
            return _this.filterWords();
          }
        }));
      }

      AdminWordsView.prototype.filterWords = function() {
        var focusGPCs, knownGPCs;
        knownGPCs = this.knownGPCs.models;
        focusGPCs = this.knownGPCs.isEmpty() ? [] : [this.knownGPCs.last()];
        return this.search.getKnownFocusItems(knownGPCs, focusGPCs);
      };

      return AdminWordsView;

    })(CompositeView);
  });

}).call(this);
