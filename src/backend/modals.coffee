BrowserWindow = require 'browser-window'

settingsWindow = null

exports.openSettings = ->
  return unless settingsWindow == null
  settingsWindow = new BrowserWindow({width: 600, height: 400, 'always-on-top': true})

  settingsWindow.loadUrl('file://' + __dirname + '/../../html/settings/edit_modal.html')

  settingsWindow.on 'closed', ->
    settingsWindow = null
