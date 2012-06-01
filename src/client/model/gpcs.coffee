class GPC extends NamedModel
  constructor: (attributes, options) ->
    # _.bindAll @, 'graphemeName'
    super attributes, options

  graphemeName: ->
    grapheme = @get 'grapheme'
    if grapheme?
      grapheme.get 'name'
    else
      null

  parse: (data) ->
    @parseIdLookup 'graphemes', 'grapheme', data
    @parseIdLookup 'phonemes', 'phoneme', data
    data


class GPCs extends NamedCollection
  model: GPC
  url: '/api/v1/gpcs/'

  constructor: (models, options) ->
    options ?= {}
    @graphemes = options.graphemes
    @phonemes = options.phonemes

    super models, options

class UserGPC extends BaseModel
  defaults:
    known: false
    focus: false
    gpc: null

  constructor: (attributes={}, options={}) ->
    super attributes, options


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

class UserGPCs extends BaseCollection
  model: UserGPC

  constructor: (models, options = {}) ->
    @gpcs = options.gpcs

    super models, options

    if @gpcs?
      @gpcs.on 'reset', @onGPCsReset, @
      @onGPCsReset()

  # @private
  onGPCsReset: ->
    @gpcs.each (gpc) =>
      ugpcs = @where { gpc }
      if ugpcs.length == 0
        # ugpc = new UserGPC { gpc }
        @add {gpc}, silent: true
    @trigger 'reset', @, {}


  getKnownGPCs: ->
    ugpcs = @filter (ugpc) -> ugpc.isKnown()
    _.map ugpcs, (ugpc) -> ugpc.gpc()

  getFocusGPCs: ->
    ugpcs = @filter (ugpc) -> ugpc.hasFocus()
    _.map ugpcs, (ugpc) -> ugpc.gpc()
