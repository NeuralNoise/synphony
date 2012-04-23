window.Synphony = {}

jQuery ->
  Synphony.importRouter = new ImportRouter
  Backbone.history.start()

