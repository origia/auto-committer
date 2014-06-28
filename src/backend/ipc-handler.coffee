ipc    = require 'ipc'
modals = require './modals'

exports.setup = (mainWindow) ->
  ipc.on 'open-modal', (e, name) ->
    funcName = 'open' + name
    modals[funcName]()
