window.Synphony = {}

jQuery ->
  Synphony.segmenterRouter = new SegmenterRouter
  Backbone.history.start()

