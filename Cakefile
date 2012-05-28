fs = require 'fs'

{print} = require 'util'
{spawn} = require 'child_process'

LICENSE_FILES = [ 'src/license.coffee' ]

CLIENT_MODEL_FILES = [
  'src/client/model/_named.coffee'
  'src/client/model/_store.coffee'
  'src/client/model/gpcs.coffee'
  'src/client/model/graphemes.coffee'
  'src/client/model/phonemes.coffee'
  'src/client/model/segmenter.coffee'
  'src/client/model/sentences.coffee'
  'src/client/model/sequences.coffee'
  'src/client/model/util.coffee'
  'src/client/model/wordlist.coffee'
  'src/client/model/words.coffee'
]

CLIENT_VIEW_FILES = [
  'src/client/view/_helpers.coffee'
  'src/client/view/_template.coffee'
  'src/client/view/admin.coffee'
  'src/client/view/gpcs.coffee'
  'src/client/view/wordlist.coffee'
  'src/client/view/words.coffee'
  'src/client/router/admin.coffee'
  'src/client/router/segmenter.coffee'
  'src/client/synphony.coffee'
]

SPEC_FILES = [
  'tests/client/db.spec.coffee'
  'tests/client/gpcs.spec.coffee'
  'tests/client/graphemes.coffee'
  'tests/client/named.spec.coffee'
  'tests/client/phonemes.spec.coffee'
  'tests/client/segmenter.spec.coffee'
  'tests/client/sentences.spec.coffee'
  'tests/client/sequences.spec.coffee'
  'tests/client/spec_helpers.coffee'
  'tests/client/util.spec.coffee'
  'tests/client/wordlist.spec.coffee'
  'tests/client/words.spec.coffee'
]

CLIENT_FILES = LICENSE_FILES.concat(CLIENT_MODEL_FILES).concat(CLIENT_VIEW_FILES)
TEST_FILES = LICENSE_FILES.concat(CLIENT_MODEL_FILES).concat(SPEC_FILES)

COFFEE = if process.platform is 'win32'
  'C:/Users/Norbert/AppData/Roaming/npm/coffee.cmd'
else
  'coffee'

HANDLEBARS = if process.platform is 'win32'
  'C:/Users/Norbert/AppData/Roaming/npm/handlebars.cmd'
else
  'handlebars'

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

task 'build', 'Build build/ from src/', ->
  spawnCoffee ['-c', '-o', 'build/server', 'src/server']
  spawnCoffee ['-c', '-j', 'build/client/synphony.js'].concat(CLIENT_FILES)
  spawnCoffee ['-c', '-j', 'build/client/tests.js'].concat(TEST_FILES)

task 'watch', 'Build build/ from src/', ->
  spawnCoffee ['-w', '-c', '-o', 'build/server', 'src/server']
  spawnCoffee ['-w', '-c', '-j', 'build/client/synphony.js'].concat(CLIENT_FILES)
  spawnCoffee ['-w', '-c', '-j', 'build/client/tests.js'].concat(TEST_FILES)

task 'precompile', 'Precompile handlebars templates', ->
  spawnHandlebars ['templates', '-f', 'build/client/templates.js']

task 'unicode', 'Downloads and compiles unicode stuffs', ->
  unicodeCompiler = require './src/server/unicode_compiler'
  unicodeCompiler.run (err) ->
    if err?
      console.log err
    else
      console.log "Success"
