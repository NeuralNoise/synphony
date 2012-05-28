fs = require 'fs'

{print} = require 'util'
{spawn} = require 'child_process'

spawner = (cmd, opts, callback) ->
  coffee = spawn cmd, opts
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

spawnCoffee = (opts, callback) ->
  spawner('C:/Users/Norbert/AppData/Roaming/npm/coffee.cmd', opts, callback)

spawnHandlebars = (opts, callback) ->
  spawner('C:/Users/Norbert/AppData/Roaming/npm/handlebars.cmd', opts, callback)

task 'build', 'Build build/ from src/', ->
  spawnCoffee ['-c', '-o', 'build/server', 'src/server']
  spawnCoffee ['-c', '-j', 'build/client/synphony.js', 'src/client']
  spawnCoffee ['-c', '-j', 'build/client/tests.js', 'src/client/model', 'tests/client']

task 'watch', 'Build build/ from src/', ->
  spawnCoffee ['-w', '-c', '-o', 'build/server', 'src/server']
  spawnCoffee ['-w', '-c', '-j', 'build/client/synphony.js', 'src/client']
  spawnCoffee ['-w', '-c', '-j', 'build/client/tests.js', 'src/client/model', 'tests/client']

task 'precompile', 'Precompile handlebars templates', ->
  spawnHandlebars ['templates', '-f', 'build/client/templates.js']

task 'unicode', 'Downloads and compiles unicode stuffs', ->
  unicodeCompiler = require './src/server/unicode_compiler'
  unicodeCompiler.run (err) ->
    if err?
      console.log err
    else
      console.log "Success"
