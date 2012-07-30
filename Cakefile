fs = require 'fs'

{print} = require 'util'
{spawn} = require 'child_process'
{_} = require 'underscore'


if process.platform is 'win32'
  # 'C:/Users/Norbert/AppData/Roaming/npm/coffee.cmd'
  regex = /\\/g # to fix syntax highlighting issue in sublime
  BINPATH = (process.env.APPDATA.replace regex, '/')+"/npm/"
  EXTENSION = '.cmd'
else
  ''

COFFEE = BINPATH + 'coffee' + EXTENSION

HANDLEBARS = BINPATH + 'handlebars' + EXTENSION

CODO = BINPATH + 'codo' + EXTENSION

spawner = (cmd, opts, callback) ->
  coffee = spawn cmd, opts
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

spawnCoffee = (opts, callback) ->
  spawner(COFFEE, opts, callback)

spawnHandlebars = (opts, callback) ->
  spawner(HANDLEBARS, opts, callback)

spawnCodo = (opts, callback) ->
  spawner(CODO, opts, callback)

task 'build', 'Build build/ from src/', ->
  spawnCoffee ['-c', '-o', 'build/server', 'src/server']
  spawnCoffee ['-c', '-o', 'build/client', 'src/client']
  spawnCoffee ['-c', '-o', 'build/test', 'tests']

task 'watch', 'Build build/ from src/', ->
  spawnCoffee ['-w', '-c', '-o', 'build/server', 'src/server']
  spawnCoffee ['-w', '-c', '-o', 'build/client', 'src/client']
  spawnCoffee ['-w', '-c', '-o', 'build/tests', 'tests']

task 'precompile', 'Precompile handlebars templates', ->
  spawnHandlebars ['templates', '-f', 'build/client/templates.js']

task 'doc', 'Compile docs', ->
  walk = require('walkdir')
  files = walk.sync('src/client')
  files = _.filter files, (file) -> /\.coffee$/.test(file)
  files = _.sortBy files, (file) ->
    parts = file.split('/')
    parts[parts.length - 1]
  spawnCodo ['--readme', 'README.md', '-o', 'doc'].concat(files)
