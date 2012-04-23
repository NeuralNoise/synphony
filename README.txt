SynPhony

Synthetic Phonics project

Notes:

- using coffeescript to simplify code and make it more readable/maintainable
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
