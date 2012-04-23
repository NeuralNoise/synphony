express = require 'express'
jsondb = require './jsondb'

staticFile = (root, path) ->
  (req, res) ->
    next = (err) ->
      if err
        console.log(err)
        res.send(500)
      else
        res.send(404)
    express.static.send req, res, next,
      getOnly: true
      root: __dirname+'/../..'+root
      path: path

module.exports.run = ->
  app = express.createServer()
  db = new jsondb.JsonDb __dirname+'/../../data/db.json'
  db.load()

  app.use express.favicon()
  app.use express.logger()
  app.use express.static __dirname+'/../../public'
  app.use express.bodyParser()
  app.use express.methodOverride()

  app.get '/js/libs/json2.js', (staticFile '/node_modules/JSON', 'json2.js')
  app.get '/js/libs/underscore.js', (staticFile '/node_modules/underscore', 'underscore.js')
  app.get '/js/libs/backbone.js', (staticFile '/node_modules/backbone', 'backbone.js')
  app.get '/js/synphony.js', (staticFile '/build/client', 'synphony.js')
  app.get '/js/templates.js', (staticFile '/build/client', 'templates.js')

  app.get '/api/v1/:collection/?', (req, res) ->
    res.json db.all req.params.collection

  app.post '/api/v1/:collection/?', (req, res) ->
    res.json db.put req.params.collection, req.body

  app.get '/api/v1/:collection/:id/?', (req, res) ->
    res.json db.get req.params.collection, req.params.id

  app.put '/api/v1/:collection/:id/?', (req, res) ->
    req.body.id = req.params.id
    res.json db.put req.params.collection, req.body

  app.delete '/api/v1/:collection/:id/?', (req, res) ->
    res.json db.delete req.params.collection, req.params.id

  port = 3000
  app.listen port
  console.log "You may go to http://localhost:#{port}/ in your browser"
