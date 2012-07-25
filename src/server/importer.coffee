thedb = require './db'
{EventEmitter} = require 'events'
{_} = require 'underscore'
fs = require 'fs'

foreignKeys =
  gpcs: ["phoneme", "grapheme"]
  words: ["gpcs"]
  sentences: ["words"]
  sequences: [
    { elements: ["gpc", "new_words", "new_sentences"] }
  ]

class Importer extends EventEmitter
  constructor: (@databaseUrl, @projectName, @filename) ->
    @objectIds = {}
    # workflow for importing
    @on "start", _.bind @loadJson, @
    @on "json-loaded", _.bind @loadDatabase, @
    @on "database-loaded", _.bind @ensureCollections, @
    @on "collections-ensured", _.bind @nextCollection, @
    @on "collection-selected", _.bind @fixDocumentIds, @
    @on "ids-fixed", _.bind @nextDocument, @
    @on "collection-done", _.bind @nextCollection, @
    @on "document-selected", _.bind @insertDocument, @
    @on "document-inserted", _.bind @nextDocument, @
    @on "collections-done", _.bind @done, @

  run: ->
    @emit "start"

  loadJson: ->
    fs.readFile @filename, 'utf8',
      @whenDone "json-loaded", (data) =>
        @data = JSON.parse(data)

  loadDatabase: ->
    @db = new thedb.Db @databaseUrl
    @db.load @whenDone "database-loaded"

  ensureCollections: ->
    @collectionNames = _.keys @data
    console.log "Ensuring collections"
    @db.ensureCollections @projectName, @collectionNames, @whenDone "collections-ensured"

  nextCollection: ->
    @collectionName = @collectionNames.shift()
    if not @collectionName?
      @emit "collections-done"
    else
      console.log @collectionName
      @collectionData = @data[@collectionName]
      @emit "collection-selected"

  fixDocumentIds: ->
    if foreignKeys[@collectionName]?
      @mapForeignKeys(@collectionData, foreignKeys[@collectionName])
    # for data in @collectionData
    #   if data.id?
    #     data._id = data.id
    #     delete data.id
    @emit "ids-fixed"

  nextDocument: ->
    @document = @collectionData.shift()
    if not @document?
      @emit "collection-done"
    else
      console.log "  #{@document.name ? @document.id}"
      # prevent call stack getting too full
      process.nextTick =>
        @emit "document-selected"

  insertDocument: ->
    id = @document.id
    delete @document.id
    query = null
    query = { name: @document.name } if @document.name?
    @db.put @projectName, @collectionName, query, @document, @whenDone "document-inserted", (result) =>
      @objectIds[id] = result._id.toString()
      console.log "    #{id} => #{result._id}"

  done: ->
    console.log "\ndone"
    @db.close()
    # @emit "done"

  # @private
  whenDone: (event, handler) ->
    return (err, result) =>
      if err?
        console.error err
        @emit "error", err
      else
        if handler?
          handler(result)
        @emit event

  # @private
  mapForeignKeys: (collectionData, foreignKeys) ->
    return if not collectionData?
    for data in collectionData
      for field in foreignKeys
        if not _.isString field
          for key, fields of field
            @mapForeignKeys data[key], fields
        else if _.isArray data[field]
          data[field] = (for id in data[field]
            if not @objectIds[id]?
              console.error "    Bad array id: #{id}"
            @objectIds[id])
        else
          if not @objectIds[data[field]]?
            console.error "    Bad id: #{data[field]}"
          data[field] = @objectIds[data[field]]


module.exports.run = () ->
  [databaseUrl, projectName, filename] = _.rest process.argv, 2
  console.log "Importing #{filename} into project #{projectName} in database #{databaseUrl}"
  (new Importer databaseUrl, projectName, filename).run()
