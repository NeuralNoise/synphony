adminRouter = null
store = null

jQuery ->
  # Only put jQuery things here that are not worth the effort of
  # making a whole view for them. If you find you need state or
  # access to the model, make a view instead.
  ($ '#side-panel-toggle').click ->
    # ($ '#control-panel').toggle 'fast', 'swing'
    # ($ '#side-panel').toggle 'fast', 'swing'
    ($ '#control-panel').toggleClass 'is-collapsed'
    ($ '#side-panel').toggleClass 'is-collapsed'
    ($ '#side-panel-toggle').toggleClass 'active'

  store = new Store
  store.loadAll (error) ->
    if error?
      alert error
    else
      adminRouter = new AdminRouter { store }
      Backbone.history.start()

