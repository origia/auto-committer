ipc = require 'ipc'

exports.setup = (mainWindow) ->
  ipc.on 'refresh', ->
    mainWindow.reload()

  ipc.on 'toggleTools', ->
    mainWindow.toggleDevTools()
