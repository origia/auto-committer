BrowserWindow = require 'browser-window'

settingsWindow = null

exports.openSettings = ->
  return unless settingsWindow == null
  settingsWindow = new BrowserWindow({width: 600, height: 400, 'always-on-top': true})

  settingsWindow.loadUrl('file://' + __dirname + '/../../html/layouts/app.html')
  settingsWindow.webContents.on 'did-finish-load', ->
    settingsWindow.webContents.send 'change-page', '/settings'

  settingsWindow.on 'closed', ->
    settingsWindow = null
