define ['collection/named', 'model/phoneme'], (NamedCollection, Phoneme) ->
  # Collection of phonemes.
  class Phonemes extends NamedCollection
    model: Phoneme
    collectionUrl: 'phonemes'
