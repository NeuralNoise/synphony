define ['model/named'], (NamedModel)->
  class Word extends NamedModel

    parse: (data) ->
      @parseIdLookup 'gpcs', 'gpcs', data
      data
