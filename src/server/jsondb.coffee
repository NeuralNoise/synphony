fs = require 'fs'
_ = (require 'underscore')._
crypto = require 'crypto'

ID_BYTES = 8

class JsonDb
  constructor: (filename) ->
    @filename = filename
    @db = Object.create null

  load: ->
    try
      json = fs.readFileSync @filename, 'utf8'
      @db = JSON.parse json
    catch e
      console.log "DB Error: #{e}"

  flush: (callback) ->
    fs.writeFile @filename, (JSON.stringify @db), 'utf8', callback

  all: (collection) ->
    @db[collection] ? []

  get: (collection, id) ->
    return null unless @db[collection]?
    _.find @db[collection], (item) ->
      item.id == id

  put: (collection, data) ->
    data = JSON.parse JSON.stringify data
    if not data.id?
      data.id = crypto.randomBytes(ID_BYTES).toString 'hex'
    @db[collection] ||= []
    @db[collection].push data
    @flush
    data

  delete: (collection, id) ->
    item = @get collection, id
    if item?
      @db[collection] = _.reject @db[collection], (item) -> item.id == id
      @flush
    item

module.exports.JsonDb = JsonDb
