define ['underscore', 'collection/base', 'model/user_gpc'], (_, BaseCollection, UserGPC) ->
  class UserGPCs extends BaseCollection
    model: UserGPC
    url: '/api/v1/user_gpcs/'

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
      console.log "user gpcs reset because gpcs reset:", @length
      @trigger 'reset', @, {}


    getKnownGPCs: ->
      ugpcs = @filter (ugpc) -> ugpc.isKnown()
      _.map ugpcs, (ugpc) -> ugpc.gpc()

    getFocusGPCs: ->
      ugpcs = @filter (ugpc) -> ugpc.hasFocus()
      _.map ugpcs, (ugpc) -> ugpc.gpc()
