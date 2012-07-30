# This is the HTTP Server for providing the files over HTTP.
#
# Level: low
#
# Here the API in on URLs /api/v1/<collection>/[<id>]
# Some javascripts are pulled from node_modules folder under
# /js/lib/* urls.
# Some scripts pulled from build folder.
# The rest is in the public folder.

express = require 'express'
thedb = require './db'
less = require 'less'
fs = require 'fs'
path = require 'path'
auth = require './auth'
gzip = require 'connect-gzip'
{_} = require 'underscore'

# Either use mongolab or localhost
DATABASE_URL = process.env.MONGOLAB_URI ? "mongodb://localhost:27017/synphony"

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

staticPath = (root, path) ->
  (req, res) ->
    url = req.url
    if url.indexOf(path) != 0
      console.log "Orig URL: #{url}"
      return res.send 404
    url = url.substring(path.length)
    console.log "URL: #{url}"

    next = (err) ->
      if err
        console.log err
        res.send 500
      else
        res.send 404
    express.static.send req, res, next,
      getOnly: true
      root: __dirname+'/../..'+root
      path: url


compileStyle = (callback) ->
  fs.readFile __dirname+'/../../src/style/synphony.less', 'utf8', (err, data) ->
    if err
      return callback err

    console.log path.resolve(__dirname, '../../src/style/')
    options =
      paths: [path.resolve(__dirname, '../../src/style/')]
      filename: "synphony.less"
      file: "synphony.less"
    less.render data, options, (err, css) ->
      callback err, css


module.exports.run = ->
  app = express.createServer()
  db = new thedb.Db DATABASE_URL
  db.load (err) ->
    if err?
      console.error err.toString()
    else
      db.ensureCollections null, [
        'users', 'projects'
      ], (err) ->
        if err?
          console.error err.toString()

  port = process.env.PORT ? 3000
  baseUrl = "http://localhost:#{port}/"

  findOrCreateUser = (identifier, profile, done) ->
    user = _.clone profile
    user.open_id = identifier

    db.put null, 'users', {'open_id': identifier}, user, (err, user) ->
      if err?
        console.log err
      done err, user

  serializeUser = (user, done) ->
    done null, user._id.toString()

  deserializeUser = (id, done) ->
    user = db.get null, 'users', {_id: id}, (err, user) ->
      if err?
        console.log err
      done err, user

  app.use express.favicon __dirname+'/../../public/favicon.ico'
  app.use express.static __dirname+'/../../public'
  app.use gzip.gzip()
  app.use express.logger()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser process.env.COOKIE_SECRET ? 'fRqnPNEZ5QH3BPKMtasPjQgTLjBAnJgzE8fS7lof'
  app.use express.session()
  passport = auth.setup baseUrl, app, findOrCreateUser, serializeUser, deserializeUser

  app.get '/js/synphony.js', (staticFile '/build/client', 'synphony.js')
  app.get '/js/templates.js', (staticFile '/build/client', 'templates.js')

  for folder in ['collection', 'model', 'router', 'view', 'view_model', 'interactor']
    url = "/js/#{folder}"
    app.get "#{url}/:file.js", (staticPath "/build/client/#{folder}", url)
  app.get "/js/view/:folder/:file.js", (staticPath "/build/client/view", "/js/view")

  app.get "/templates/:folder/:file.handlebars", (staticPath "/templates", "/templates")

  app.get '/css/synphony.css', (req, res) ->
    compileStyle (error, css) ->
      if error
        res.send 500, error
      else
        res.contentType 'text/css'
        res.send css

  app.get '/api/v1/:project/:collection/?', (req, res) ->
    db.all req.params.project, req.params.collection, null, (err, docs) ->
      if err?
        res.send 500, err
      else
        res.json docs

  app.post '/api/v1/:project/:collection/?', (req, res) ->
    db.put req.params.project, req.params.collection, null, req.body, (err, doc) ->
      if err?
        res.send 500, error
      else
        res.json doc

  app.get '/api/v1/:project/:collection/:id/?', (req, res) ->
    db.get req.params.project, req.params.collection, {_id: req.params.id}, (err, doc) ->
      if err?
        res.send 500, error
      else if doc?
        res.json doc
      else
        res.send 404, "No such document"

  app.put '/api/v1/:project/:collection/:id/?', (req, res) ->
    req.body._id = req.params.id
    db.put req.params.project, req.params.collection, {_id: req.params.id}, req.body, (err, doc) ->
      if err?
        res.send 500, error
      else
        res.json doc

  app.delete '/api/v1/:project/:collection/:id/?', (req, res) ->
    db.delete req.params.project, req.params.collection, {_id: req.params.id}, (err) ->
      if err?
        res.send 500, error
      else
        res.send 204

  app.listen port
  console.log "You may go to #{baseUrl} in your browser"
