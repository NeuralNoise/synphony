mongo = require 'mongodb'
{_} = require 'underscore'

class Db
  constructor: (database, host="127.0.0.1", port=27017) ->
    @adminDatabase = database
    @db_connector = new mongo.Db(database, new mongo.Server(host, port, {}))
    @dbCache = {}

  load: (done) ->
    if @db?
      done null if done?
      return

    @db_connector.open (err, db) =>
      @db = db
      done err if done?

  ensureCollections: (database=@adminDatabase, collectionNames, done) ->
    @selectDatabase(database).collectionNames (err, existingNames) =>
      existingNames = (col.options.create for col in existingNames when col.options?)
      nonexistingNames = _.difference collectionNames, existingNames
      @createCollections database, nonexistingNames, done

  createCollections: (database=@adminDatabase, collectionNames, done) ->
    return (done null) if collectionNames.length == 0
    collectionName = collectionNames.shift()
    @selectDatabase(database).createCollection collectionName, {safe: true}, (err) =>
      return (done err) if err?
      @createCollections database, collectionNames, done

  all: (database=@adminDatabase, collectionName, query, done) ->
    query = @patchObjectID query
    @selectDatabase(database).collection collectionName, (err, collection) ->
      return (done err) if err?
      collection.find(query).toArray (err, docs) ->
        done err, docs

  get: (database=@adminDatabase, collectionName, query, done) ->
    query = @patchObjectID query
    @selectDatabase(database).collection collectionName, (err, collection) ->
      return (done err) if err?
      collection.findOne query, (err, doc) ->
        done err, doc

  put: (database=@adminDatabase, collectionName, query, doc, done) ->
    query = @patchObjectID query
    doc = @patchObjectID doc
    @selectDatabase(database).collection collectionName, (err, collection) ->
      return (done err) if err?
      if not query? and doc._id?
        query = {_id: doc._id}
      if query?
        collection.findAndModify query, [], doc, {upsert: true, new: true, safe: true}, (err, doc) ->
          done err, doc
      else
        collection.insert doc, {safe: true}, (err, doc) ->
          done err, doc

  delete: (database=@adminDatabase, collectionName, query, done) ->
    query = @patchObjectID query
    @selectDatabase(database).collection collectionName, (err, collection) ->
      return (done err) if err?
      collection.remove query, {safe: true}, (err) ->
        done err

  close: ->
    @db.close()

  # @private
  selectDatabase: (database) ->
    if @adminDatabase == database
      @db
    else if @dbCache[database]
      @dbCache[database]
    else
      @dbCache[database] = @db.db(database)

  # @private
  patchObjectID: (obj) ->
    return obj if not obj?
    if obj._id? and not (obj._id instanceof mongo.ObjectID)
      obj._id = mongo.ObjectID(obj._id)
    return obj

exports.Db = Db
