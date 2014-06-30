_             = require 'underscore'
BrowserWindow = require 'browser-window'
Menu          = require 'menu'

modals = {}

createModal = (name, path, dimensions) ->
  return if modals[name]?
  options = _.extend({'always-on-top': true}, dimensions)
  modal = new BrowserWindow(options)
  unless process.platform == 'darwin'
    modal.setMenu(new Menu())
  modal.loadUrl('file://' + __dirname + '/../../html/layouts/app.html')
  modal.webContents.on 'did-finish-load', ->
    modal.webContents.send 'change-page', path
  modal.on 'closed', ->
    modals[name] = null
  modals[name] = modal

exports.openSettings = ->
  createModal 'settings', '/settings', {width: 600, height: 400, resizable: false}

exports.openCreateRepo = ->
  createModal 'create-repo', '/create-repo', {width: 600, height: 250, resizable: false}
