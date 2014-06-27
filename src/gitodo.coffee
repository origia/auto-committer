app        = require './backend/app'
ipcHandler = require './backend/ipc-handler'
#db         = require './configuration/database'

app.init (mainWindow) ->
  ipcHandler.setup mainWindow
