define ['model/named', 'collection/sequence_elements'], (NamedModel, SequenceElements) ->
  class Sequence extends NamedModel
    elements: -> @get 'elements'

    gpcs: -> @elements().getGpcs()

    parse: (data) ->
      if data.elements?
        data.elements = new SequenceElements data.elements, {parse: true, collection: @}
      data
