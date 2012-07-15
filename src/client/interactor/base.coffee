define ['backbone'], (Backbone) ->
  # Base superclass for all SynPhony interactors.
  # An interactor is a composable object that implements use cases directly.
  # It should have at least one method named run, be named for the use case,
  # and be asynchronous. Every effort should be made to make sure it is
  # composable. It may also emit events that other interactors can listen to.
  #
  # @abstract
  # @see http://backbonejs.org/#Events Backbone.Events
  class BaseInteractor extends Backbone.Events
    # Perform whatever interaction the interactor is meant to do. This
    # could be asynchronous, so the result will be returned via a callback.
    # @param [function(error, data) {}] callback called when done
    run: (callback) ->
      callback(null, null)