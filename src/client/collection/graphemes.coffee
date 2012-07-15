define ['collection/named', 'model/grapheme'], (NamedCollection, Grapheme) ->
  # A collection of graphemes.
  class Graphemes extends NamedCollection
    model: Grapheme
    collectionUrl: 'graphemes'
