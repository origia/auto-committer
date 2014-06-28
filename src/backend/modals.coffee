BrowserWindow = require 'browser-window'

settingsWindow   = null
createRepoWindow = null

exports.openSettings = ->
  return unless settingsWindow == null
  settingsWindow = new BrowserWindow({width: 600, height: 400, 'always-on-top': true})

  settingsWindow.loadUrl('file://' + __dirname + '/../../html/layouts/app.html')
  settingsWindow.webContents.on 'did-finish-load', ->
    settingsWindow.webContents.send 'change-page', '/settings'

  settingsWindow.on 'closed', ->
    settingsWindow = null

exports.openCreateRepo = ->
  return unless createRepoWindow == null
  createRepoWindow = new BrowserWindow({width: 600, height: 400, 'always-on-top': true})

  createRepoWindow.loadUrl('file://' + __dirname + '/../../html/layouts/app.html')
  createRepoWindow.webContents.on 'did-finish-load', ->
    createRepoWindow.webContents.send 'change-page', '/create-repo'

  createRepoWindow.on 'closed', ->
    createRepoWindow = null
