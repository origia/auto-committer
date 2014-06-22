BrowserWindow = require 'browser-window'

exports.openSettings = ->
  settingsWindow = new BrowserWindow({width: 600, height: 400, frame: false})

  settingsWindow.loadUrl('file://' + __dirname + '/../../html/settings/edit_modal.html')

  settingsWindow.on 'closed', ->
    settingsWindow = null


  # settings.show()
