Menu = require 'menu'
modals = require './modals'

exports.initMenu = (app) ->
  template = [
    label: 'AutoCommitter'
    submenu: [
      label: '環境設定…'
      accelerator: 'Command+,',
      selector: 'settings:',
      click: modals.openSettings
    ,
    {
      type: 'separator'
    }
    ,
      label: 'AutoCommitter を隠す'
      accelerator: 'Command+H',
      selector: 'hide:'
    ,
      label: '他のアプリケーションを隠す',
      accelerator: 'Command+Shift+H',
      selector: 'hideOtherApplications:'
    ,
      label: 'すべて表示',
      selector: 'unhideAllApplications:'
    {
      type: 'separator'
    }
    ,
      label: 'AutoCommitter を終了'
      accelerator: 'Command+Q',
      click: ( -> app.quit() )
    ]
  ]

  menu = Menu.buildFromTemplate(template)
  Menu.setApplicationMenu(menu)
