define ['collection/named', 'model/phoneme'], (NamedCollection, Phoneme) ->
  class Phonemes extends NamedCollection
    model: Phoneme
    collectionUrl: 'phonemes'
