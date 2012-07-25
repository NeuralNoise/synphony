// Generated by CoffeeScript 1.3.3
(function() {

  requirejs.config({
    baseUrl: 'js/',
    paths: {
      handlebars: 'libs/handlebars',
      backbone: 'libs/backbone',
      jquery: ['http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min', 'libs/jquery-1.7.2.min'],
      underscore: 'libs/underscore',
      text: 'libs/text',
      i18n: 'libs/i18n',
      templates: '../templates'
    },
    shim: {
      backbone: {
        deps: ['underscore', 'jquery'],
        exports: 'Backbone'
      },
      underscore: {
        deps: [],
        exports: '_'
      },
      handlebars: {
        deps: [],
        exports: 'Handlebars'
      }
    },
    enforceDefine: true
  });

  define(['jquery', 'router/application_initializer'], function($, ApplicationInitializer) {
    return $(function() {
      ($('#side-panel-toggle')).click(function() {
        ($('#control-panel')).toggle();
        ($('#side-panel')).toggle();
        return ($('#side-panel-toggle')).toggleClass('active');
      });
      return (new ApplicationInitializer).run();
    });
  });

}).call(this);
