define ['model/named'], (NamedModel)->
  class Word extends NamedModel

    gpcs: -> @get 'gpcs'
    name: -> @get 'name'

    parse: (data) ->
      @parseIdLookup 'gpcs', 'gpcs', data
      data
