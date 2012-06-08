define ['collection/named', 'model/phoneme'], (NamedCollection, Phoneme) ->
  class Phonemes extends NamedCollection
    model: Phoneme
    url: '/api/v1/phonemes/'
