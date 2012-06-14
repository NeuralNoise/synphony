// Generated by CoffeeScript 1.3.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  define(['backbone', 'view/common/layout', 'view/common/menu', 'view/common/sidebar', 'view/admin/words', 'view/admin/sentences', 'view/gpc/button', 'view/common/collection'], function(Backbone, Layout, MenuView, SidebarView, WordsView, SentencesView, GPCButtonView, CollectionView) {
    var AdminRouter;
    return AdminRouter = (function(_super) {

      __extends(AdminRouter, _super);

      AdminRouter.name = 'AdminRouter';

      AdminRouter.prototype.routes = {
        "": "home",
        "words": "words",
        "sentences": "sentences"
      };

      AdminRouter.prototype.menu = {
        "Words": "#words",
        "Sentences": "#sentences"
      };

      AdminRouter.prototype.sidebar = function() {
        return {
          'Spelling Patterns': this.makeSpellingPatterns()
        };
      };

      function AdminRouter(options) {
        AdminRouter.__super__.constructor.call(this, options);
        this.store = options.store;
        this.layout = new Layout({
          menu: "#main-menu",
          content: "#main-content",
          sidebar: "#toolbar-content"
        });
        this.setup = false;
      }

      AdminRouter.prototype.home = function() {
        return this.navigate('words', {
          trigger: true,
          replace: true
        });
      };

      AdminRouter.prototype.words = function() {
        console.log("Showing admin words page");
        return this.showContent(new WordsView({
          store: this.store
        }));
      };

      AdminRouter.prototype.sentences = function() {
        console.log("Showing admin sentences page");
        return this.showContent(new SentencesView({
          store: this.store
        }));
      };

      AdminRouter.prototype.makeSpellingPatterns = function() {
        return new CollectionView({
          id: 'spelling-patterns',
          collection: this.store.sequences().first().elements(),
          knownGPCs: this.store.knownGPCs(),
          modelView: GPCButtonView
        });
      };

      AdminRouter.prototype.setupDefaultViews = function() {
        if (this.setup) {
          return;
        }
        this.setup = true;
        this.layout.menu.render(new MenuView({
          model: {
            menu: this.menu
          }
        }));
        return this.layout.sidebar.render(new SidebarView({
          model: {
            sections: this.sidebar()
          }
        }));
      };

      AdminRouter.prototype.showContent = function(view) {
        this.setupDefaultViews();
        return this.layout.content.render(view);
      };

      return AdminRouter;

    })(Backbone.Router);
  });

}).call(this);
