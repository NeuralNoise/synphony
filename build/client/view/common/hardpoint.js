// Generated by CoffeeScript 1.3.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  define(['view/common/base'], function(BaseView) {
    var Hardpoint;
    return Hardpoint = (function(_super) {

      __extends(Hardpoint, _super);

      Hardpoint.name = 'Hardpoint';

      function Hardpoint(options) {
        Hardpoint.__super__.constructor.call(this, options);
        this.view = null;
      }

      Hardpoint.prototype.setView = function(view) {
        if (this.view) {
          this.view.destroy();
        }
        this.view = view;
        return this;
      };

      Hardpoint.prototype.render = function(view) {
        if (view == null) {
          view = null;
        }
        if (view) {
          this.setView(view);
        }
        return this.$el.html(this.view.render().el);
      };

      Hardpoint.prototype.destroy = function() {
        this.view.destroy();
        this.view = null;
        return Hardpoint.__super__.destroy.call(this);
      };

      return Hardpoint;

    })(BaseView);
  });

}).call(this);