app        = require './backend/app'
ipcHandler = require './backend/ipc-handler'

db = require './configuration/database'
require './models'
db.sync()

app.init (mainWindow) ->
  ipcHandler.setup mainWindow
