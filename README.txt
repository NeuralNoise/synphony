= SynPhony =

Synthetic Phonics project. Primarily useful for early grade literacy teaching.

== Dependancies ==

Install node.js and npm then:

npm install

This should get you everything you need. You may want to install these globally:

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

Make sure you build and precompile, then do:

node synphony_server.js

== Testing ==

open tests/SpecRunner.html in your browser after you have run cake build

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
- client folder is split into model, view, router
  - each sub-file contains one or more classes on a specific topic

== License and Copyright ==

SynPhony: Synthetic Phonics tool for early grade literacy teaching
Copyright (C) 2012  Ryan J. Sanche  <ryan@rj45.ca>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

See LICENSE.txt for more details.

