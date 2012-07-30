define ['backbone', 'underscore'], (Backbone, _) ->
  # Base superclass for all SynPhony interactors.
  # An interactor is a composable object that implements use cases directly.
  # It should have at least one method named run, be named for the use case,
  # and be asynchronous. Every effort should be made to make sure it is
  # composable. It may also emit events that other interactors can listen to.
  #
  # @abstract
  # @see http://backbonejs.org/#Events Backbone.Events
  class BaseInteractor
    # For some odd reason Backbone.Events is a mixin not a class
    # so let's mix it in
    _.extend BaseInteractor.prototype, Backbone.Events

    # Perform whatever interaction the interactor is meant to do. This
    # could be asynchronous, so the result will be returned via a callback.
    # @param [function(error, data) {}] callback called when done
    run: (callback) ->
      callback(null, null)

    # Helper function to delgate model events to the interactor for the
    # view layer to listen to.
    # @param [Backbone.Events] eventProducer the producer of the event to delegate
    # @param [String] eventName the event name
    # @param [String] newEventName optional different name
    delegateEvent: (eventProducer, eventName, newEventName=eventName) ->
      handler = (args...) ->
        @trigger newEventName, args...
      @_delegatedEvents ?= []
      @_delegatedEvents.push {producer: eventProducer, name: eventName, handler}
      eventProducer.on eventName, handler, @

    # Called to clean up cyclical references between the interactor and
    # the model layer. Also removes any event listeners.
    destroy: ->
      if @_delegatedEvents?
        for event in @_delegatedEvents
          event.producer.off event.name, event.handler, @
      @_delegatedEvents = []
      @off()