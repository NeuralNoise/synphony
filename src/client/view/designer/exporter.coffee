define ['view/common/template', 'interactor/tangerine_exporter'
  'text!templates/designer/exporter.handlebars'],
(TemplateView, TangerineExporter, hbsTemplate) ->
  # The Tangerine export page.
  class ExporterView extends TemplateView
    id: 'export-page'
    template: hbsTemplate

    constructor: (options) ->
      super options
      @blob = null

    templateData: ->
      if @blob?
        console.log "Trying to make url"
        # FIXME? Will this leak memory if not revoked?
        blobUrl = (window.URL or window.webkitURL).createObjectURL @blob
        console.log "New blob URL: #{blobUrl}"
        url: blobUrl
      else
        console.log "Got here"
        _.defer () =>
          @interactor.run (err, data) =>
            if err?
              alert err.toString()
            else
              @makeBlob data
              @render()
        url: "#"

    makeBlob: (data) ->
      json = JSON.stringify data, null, 2
      console.log "Making blob out of: #{json}"
      @blob = new Blob [json], type: "application/json"

