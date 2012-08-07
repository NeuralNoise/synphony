define ['interactor/base'], (BaseInteractor) ->
  # In order to build a cirriculum
  # As a curriculum designer
  # I want to be able to design it with a wizard to walk me through the steps.
  class CirriculumDesigner extends BaseInteractor
    constructor: (options) ->