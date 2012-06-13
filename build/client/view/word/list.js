// Generated by CoffeeScript 1.3.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  define(['underscore', 'view/common/base'], function(_, BaseView) {
    var WordListView;
    return WordListView = (function(_super) {

      __extends(WordListView, _super);

      WordListView.name = 'WordListView';

      WordListView.prototype.tagName = 'table';

      WordListView.prototype.id = 'word-list';

      function WordListView(options) {
        WordListView.__super__.constructor.call(this, options);
        this.filter = options.filter || function(collection) {
          return collection.models;
        };
        this.knownGPCs = options.knownGPCs;
        this.columns = options.columns || 3;
        this.knownGPCs.on('update', this.render, this);
      }

      WordListView.prototype.wordHTML = function(word) {
        var gpcs, html,
          _this = this;
        html = "<span class='word'>";
        gpcs = word.gpcs();
        _.each(gpcs, function(gpc) {
          return html += _this.gpcHTML(gpc);
        });
        html += "</span>";
        return html;
      };

      WordListView.prototype.gpcHTML = function(gpc) {
        var focus, known;
        known = "";
        if (this.knownGPCs.isKnown(gpc)) {
          known = "known";
        }
        focus = "";
        if (this.knownGPCs.hasFocus(gpc)) {
          focus = "focus";
        }
        return "<span class='" + known + " " + focus + "'>" + (gpc.graphemeName()) + "</span>";
      };

      WordListView.prototype.render = function() {
        var column, html, words,
          _this = this;
        words = this.filter(this.collection);
        column = 0;
        html = "<tr>";
        _.each(words, function(word) {
          html += "<td>" + _this.wordHTML(word) + "</td>";
          column += 1;
          if (column >= _this.columns) {
            column = 0;
            return html += "</tr><tr>";
          }
        });
        this.$el.html(html);
        return this;
      };

      return WordListView;

    })(BaseView);
  });

}).call(this);
