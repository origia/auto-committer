app          = require './backend/app'
ipcHandler   = require './backend/ipc-handler'
RepoListener = require './backend/repository-listener'

db = require './configuration/database'

app.init (mainWindow) ->
  repoListener = new RepoListener({ autoStart: true })
  ipcHandler.setup mainWindow, repoListener
