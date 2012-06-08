define ['model/base'], (BaseModel) ->
  class UserGPC extends BaseModel
    defaults:
      known: false
      focus: false
      gpc: null

    constructor: (attributes={}, options={}) ->
      super attributes, options

    name: -> @gpc().name()

    isKnown: -> @get 'known'

    hasFocus: -> @get 'focus'

    gpc: -> @get 'gpc'

    toggle: ->
      if not @isKnown() and not @hasFocus()
        @set known: true
      else if @isKnown() and not @hasFocus()
        @set focus: true
      else
        @set known: false, focus: false
