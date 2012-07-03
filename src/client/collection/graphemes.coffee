define ['collection/named', 'model/grapheme'], (NamedCollection, Grapheme) ->
  class Graphemes extends NamedCollection
    model: Grapheme
    collectionUrl: 'graphemes'
