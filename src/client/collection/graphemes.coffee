define ['collection/named', 'model/grapheme'], (NamedCollection, Grapheme) ->
  class Graphemes extends NamedCollection
    model: Grapheme
    url: '/api/v1/graphemes/'
