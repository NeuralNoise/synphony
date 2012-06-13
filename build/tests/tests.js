// Generated by CoffeeScript 1.3.1
(function() {

  requirejs.config({
    baseUrl: '../build/client',
    paths: {
      backbone: '../../public/js/libs/backbone',
      jquery: '../../public/js/libs/jquery-1.7.2.min',
      underscore: '../../public/js/libs/underscore'
    },
    shim: {
      backbone: {
        deps: ['underscore', 'jquery'],
        exports: 'Backbone'
      },
      underscore: {
        deps: [],
        exports: '_'
      }
    },
    enforceDefine: true
  });

  define(['../tests/client/db.spec', '../tests/client/model/named.spec', '../tests/client/model/grapheme.spec', '../tests/client/model/phoneme.spec', '../tests/client/model/gpc.spec', '../tests/client/model/word.spec', '../tests/client/model/sentence.spec', '../tests/client/model/sequence.spec', '../tests/client/model/sequence_element.spec', '../tests/client/collection/named.spec', '../tests/client/collection/graphemes.spec', '../tests/client/collection/phonemes.spec', '../tests/client/collection/gpcs.spec', '../tests/client/collection/known_gpcs.spec', '../tests/client/collection/words.spec', '../tests/client/collection/sentences.spec', '../tests/client/collection/sequences.spec', '../tests/client/collection/sequence_elements.spec'], function() {
    return {};
  });

}).call(this);
