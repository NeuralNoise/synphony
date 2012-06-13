define ['collection/named', 'model/gpc'], (NamedCollection, GPC) ->
  class KnownGPCs extends NamedCollection
    model: GPC
    url: '/api/v1/known_gpcs/'

    isKnown: (gpc) ->
      @include gpc

    hasFocus: (gpc) ->
      @last() == gpc

    toggle: (gpc) ->
      if @isKnown gpc
        @remove gpc
      else
        @add gpc
