// Generated by CoffeeScript 1.3.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  define(['collection/base'], function(BaseCollection) {
    var NamedCollection;
    return NamedCollection = (function(_super) {

      __extends(NamedCollection, _super);

      NamedCollection.name = 'NamedCollection';

      function NamedCollection() {
        return NamedCollection.__super__.constructor.apply(this, arguments);
      }

      NamedCollection.prototype.getByName = function(name) {
        var model, _i, _len, _ref, _ref1;
        if (!(this._byName != null)) {
          this._byName = {};
          _ref = this.models;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            model = _ref[_i];
            if (((_ref1 = model.attributes) != null ? _ref1.name : void 0) != null) {
              this._byName[model.attributes.name] = model;
            }
          }
        }
        return this._byName[name] || null;
      };

      NamedCollection.prototype.add = function(models, options) {
        this._byName = null;
        return NamedCollection.__super__.add.call(this, models, options);
      };

      NamedCollection.prototype.remove = function(models, options) {
        this._byName = null;
        return NamedCollection.__super__.remove.call(this, models, options);
      };

      return NamedCollection;

    })(BaseCollection);
  });

}).call(this);