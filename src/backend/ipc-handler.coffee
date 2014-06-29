ipc    = require 'ipc'
modals = require './modals'
dialog = require 'dialog'

exports.setup = (mainWindow) ->
  ipc.on 'open-modal', (e, name) ->
    funcName = 'open' + name
    modals[funcName]()

  ipc.on 'refreshRepo', ->
    mainWindow.webContents.send 'refreshRepo'

  ipc.on 'show-message-dialog', (evt, options) ->
    dialog.showMessageBox mainWindow, options, (response) ->
      evt.returnValue = response
