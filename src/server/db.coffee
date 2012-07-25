mongo = require 'mongodb'
{_} = require 'underscore'
url = require 'url'

class Db
  constructor: (databaseUrl="mongodb://localhost:27017/synphony") ->
    @databaseUrl = url.parse(databaseUrl)

    # lop off the first character '/'
    database = @databaseUrl.path.substring(1)

    server = new mongo.Server(@databaseUrl.hostname, parseInt(@databaseUrl.port, 10), {})
    @dbConnector = new mongo.Db(database, server)

  load: (done) ->
    if @db?
      done null if done?
      return

    @dbConnector.open (err, db) =>
      if err
        console.error err
        return done err if done?
      if not @databaseUrl.auth?
        @db = db
        done err if done?
      else
        [username, password] = @databaseUrl.auth.split(':')
        db.authenticate username, password, (err, good) =>
          if err
            console.error err
          if not good
            console.error "Authentication failed"
            done new Error "Authentication failed" if done?
          else
            console.log "Auth successful"
            @db = db
            done err if done?

  ensureCollections: (projectName, collectionNames, done) ->
    @db.collectionNames (err, existingNames) =>
      existingNames = (col.options.create for col in existingNames when col.options?)
      nonexistingNames = (name for name in collectionNames when (@collectionName projectName, name) not in existingNames)
      @createCollections projectName, nonexistingNames, done

  createCollections: (projectName, collectionNames, done) ->
    return (done null) if collectionNames.length == 0
    collectionName = collectionNames.shift()
    @db.createCollection (@collectionName projectName, collectionName), {safe: true}, (err) =>
      return (done err) if err?
      console.log "Created #{(@collectionName projectName, collectionName)}"
      @createCollections projectName, collectionNames, done

  all: (projectName, collectionName, query, done) ->
    query = @patchObjectID query
    @selectProjectCollection projectName, collectionName, (err, collection) ->
      return (done err) if err?
      collection.find(query).toArray (err, docs) ->
        done err, docs

  get: (projectName, collectionName, query, done) ->
    query = @patchObjectID query
    @selectProjectCollection projectName, collectionName, (err, collection) ->
      return (done err) if err?
      collection.findOne query, (err, doc) ->
        done err, doc

  put: (projectName, collectionName, query, doc, done) ->
    query = @patchObjectID query
    doc = @patchObjectID doc
    @selectProjectCollection projectName, collectionName, (err, collection) ->
      return (done err) if err?
      if not query? and doc._id?
        query = {_id: doc._id}
      if query?
        collection.findAndModify query, [], doc, {upsert: true, new: true, safe: true}, (err, doc) ->
          done err, doc
      else
        collection.insert doc, {safe: true}, (err, doc) ->
          done err, doc

  delete: (projectName, collectionName, query, done) ->
    query = @patchObjectID query
    @selectProjectCollection projectName, collectionName, (err, collection) ->
      return (done err) if err?
      collection.remove query, {safe: true}, (err) ->
        done err

  close: ->
    @db.close()

  collectionName: (projectName, collectionName) ->
    if projectName?
      "#{projectName}__#{collectionName}"
    else
      collectionName

  # @private
  selectProjectCollection: (projectName, collectionName, done) ->
    @db.collection (@collectionName projectName, collectionName), done

  # @private
  patchObjectID: (obj) ->
    return obj if not obj?
    if obj._id? and not (obj._id instanceof mongo.ObjectID)
      obj._id = mongo.ObjectID(obj._id)
    return obj

exports.Db = Db
