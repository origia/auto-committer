app           = require 'app'
BrowserWindow = require 'browser-window'

exports.init = (onReady) ->
  require('crash-reporter').start()
  mainWindow = null

  app.on 'window-all-closed', ->
    unless process.platform == 'darwin'
      app.quit()

  app.on 'ready', ->
    mainWindow = new BrowserWindow({width: 800, height: 600})
    console.log __dirname + '/../../html/repositories/show.html'

    mainWindow.loadUrl('file://' + __dirname + '/../../html/repositories/show.html')
    mainWindow.toggleDevTools()

    mainWindow.on 'closed', ->
      mainWindow = null

    onReady(mainWindow)
