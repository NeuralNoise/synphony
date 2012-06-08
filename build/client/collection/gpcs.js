// Generated by CoffeeScript 1.3.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  define(['collection/named', 'model/gpc'], function(NamedCollection, GPC) {
    var GPCs;
    return GPCs = (function(_super) {

      __extends(GPCs, _super);

      GPCs.name = 'GPCs';

      GPCs.prototype.model = GPC;

      GPCs.prototype.url = '/api/v1/gpcs/';

      function GPCs(models, options) {
        if (options == null) {
          options = {};
        }
        this.graphemes = options.graphemes;
        this.phonemes = options.phonemes;
        GPCs.__super__.constructor.call(this, models, options);
      }

      return GPCs;

    })(NamedCollection);
  });

}).call(this);
