app        = require './app'
ipcHandler = require './ipc-handler'

app.init (mainWindow) ->
  ipcHandler.setup mainWindow
