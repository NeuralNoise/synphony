define ['collection/named', 'model/gpc'], (NamedCollection, GPC) ->
  # A collection of GPCs that are known by the user.
  class KnownGPCs extends NamedCollection
    model: GPC
    collectionUrl: 'known_gpcs'

    # Is a specific gpc known or not?
    # @param [GPC] gpc The gpc to check.
    # @return [Boolean] true: known false: unknown
    isKnown: (gpc) ->
      @include gpc

    # Does the gpc have the focus? In other words is it the
    # last to be clicked on?
    # @param [GPC] gpc The gpc to check.
    # @return [Boolean] true: in focus false: not
    hasFocus: (gpc) ->
      @last() == gpc

    # If the gpc is in the list of known ones remove it, otherwise
    # add it.
    # @param [GPC] gpc The gpc to toggle.
    toggle: (gpc) ->
      if @isKnown gpc
        @remove gpc
      else
        @add gpc
