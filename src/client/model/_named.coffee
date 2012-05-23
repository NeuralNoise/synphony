###
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
###

class NamedModel extends Backbone.Model
  # fix @parse not having access to @collection
  constructor: (attributes, options) ->
    @collection = options?.collection
    super attributes, options

  validate: (attribs) ->
    if not attribs.name?
      "Must have a name"
    else if @collection?
      modelsWithMyName = @collection.where name: attribs.name
      if _.isEmpty modelsWithMyName
        null
      else if modelsWithMyName.length > 1 or (_.first modelsWithMyName) != @
        "Model with name #{attribs.name} already exists"
    else
      null

  # Helper for parse() to look up an id in a collection on the @collection
  # and set the field to an instance instead of an id number. Works with arrays
  # too
  parseIdLookup: (collectionName, fieldName, data) ->
    if @collection? and @collection[collectionName]?
      if data[fieldName] instanceof Array and typeof (_.first data[fieldName]) is "number"
        # array of ids
        data[fieldName] = _.map data[fieldName], (id) =>
          item = @collection[collectionName].get(id)
          item ? id
      else if typeof data[fieldName] is "number"
        item = @collection[collectionName].get(data[fieldName])
        data[fieldName] = item ? data[fieldName]


class NamedCollection extends Backbone.Collection
  getByName: (name) ->
    if not @_byName?
      @_byName = {}
      for model in @models
        if model.attributes?.name?
          @_byName[model.attributes.name] = model
    @_byName[name] || null

  add: (models, options) ->
    @_byName = null
    super(models, options)

  remove: (models, options) ->
    @_byName = null
    super(models, options)
