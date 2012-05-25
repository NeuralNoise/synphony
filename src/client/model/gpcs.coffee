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

class GPCState extends Backbone.Model
  defaults:
    active: false
    focus: false
    gpc: null

  toggle: ->
    if not (@get 'active') and not (@get 'focus')
      @set active: true
    else if (@get 'active') and not (@get 'focus')
      @set focus: true
    else
      @set active: false, focus: false

class GPCStates extends Backbone.Collection
  model: GPCState

  constructor: (gpcs, options) ->
    if gpcs instanceof GPCs
      gpcs = gpcs.models

    models = _.map gpcs, (gpc) -> new GPCState { gpc }

    super models, options
