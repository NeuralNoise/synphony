###
# SynPhony: Synthetic Phonics tool for early grade literacy teaching
# Copyright (C) 2012  Ryan J. Sanche  <ryan@rj45.ca>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

adminRouter = null
store = null

jQuery ->
  # Only put jQuery things here that are not worth the effort of
  # making a whole view for them. If you find you need state or
  # access to the model, make a view instead.
  ($ '#side-panel-toggle').click ->
    ($ '#control-panel').toggle 'fast', 'swing'
    ($ '#side-panel').toggle 'fast', 'swing'
    ($ '#side-panel-toggle').toggleClass 'active'

  store = new Store
  store.loadAll (error) ->
    if error?
      alert error
    else
      adminRouter = new AdminRouter { store }
      Backbone.history.start()

