SynPhony
========

Synthetic Phonics project. Primarily useful for early grade literacy teaching.

Dependancies
------------

Install node.js (0.6 or higher) and npm then:

```
npm install
```

This should get you everything you need. You may want to install this globally:

```
npm install -g coffeescript
```

Building
--------

To build src/ into build/ run:

```
cake build
```

To watch coffeescript files and recompile on changes:

```
cake watch
```

Running
-------

Make sure you build, run mongodb and then do:

```
node synphony_server.js
```

Now visit http://localhost:3000/ in any browser except internet explorer.

Testing
-------

open tests/SpecRunner.html in your browser after you have run cake build

Notes
-----

- using coffeescript to simplify code and make it more readable/maintainable
  - using cake for a build script system
- requirejs for loading & modularization
- split into build, src and template folders
  - build: generated javascript files (from src folder)
  - src: original coffeescript files
  - templates: handlebars template files
- split into server and client side codebases
  - server is node.js with very simple mongodb backed rest API (for now)
  - client is backbone.js with handlebars.js for template engine
- client folder is split into model, view, interactor, router
  - interactors are composable, reusable use case objects which
    have the implementation of use cases instead of putting that
    logic in the view/model layers.
    - This idea originated from "Uncle Bob"'s rubyconf talk -- I can't
      find the link at the moment but here's a blog with links at the top:

      http://blog.8thlight.com/uncle-bob/2011/11/22/Clean-Architecture.html

License and Copyright
---------------------

```
SynPhony: Synthetic Phonics tool for early grade literacy teaching
Copyright (C) 2012  Canada Institute of Linguistics

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
```
