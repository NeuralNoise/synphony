= SynPhony =

Synthetic Phonics project

== Dependancies ==

Install node.js and npm then:

npm install -g coffeescript
npm install -g handlebars

== Building ==

To build src/ into build/ run:

cake build

To build templates from templates into build/client/templates.js run:

cake precompile

To watch coffeescript files and recompile on changes:

cake watch

== Running ==

Make sure you build, then do:

node synphony_server.js

== Notes ==

- using coffeescript to simplify code and make it more readable/maintainable
  - using cake for a build script system
- split into build, src and template folders
  - build: generated javascript files (from src and templates folders)
  - src: original coffeescript files
  - templates: handlebars template files
- split into server and client side codebases
  - server is node.js with very simple json database (for now)
  - client is backbone.js with handlebars.js for template engine
    - builds into a single javascript file for src/client
    - templates also build into a single javascript file
- client folder is split into common, segmenter, etc for the major pages
  - each then is separated into files with each file having a specific topic
