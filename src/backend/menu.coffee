Menu = require 'menu'
modals = require './modals'

exports.initMenu = (app) ->
  template = [
    label: 'AutoCommitter'
    submenu: [
      label: '設定'
      selector: 'settings:'
      click: modals.openSettings
    ,
      label: '終了'
      accelerator: 'Command+Q',
      click: ( -> app.quit() )
    ]
  ,
    label: '編集'
    submenu: [
      label: '切り取り',
      accelerator: 'Command+X'
      selector: 'cut:'
    ,
      label: 'コピー',
      accelerator: 'Command+C'
      selector: 'copy:'
    ,
      label: '貼り付け',
      accelerator: 'Command+V'
      selector: 'paste:'
    ]
  ,
    label: 'プロジェクト'
    submenu: [
      label: '作成'
      selector: 'createProject:'
    ,
      label: '閉じる'
      selector: 'closeProject:'
    ]
  ]

  menu = Menu.buildFromTemplate(template)
  Menu.setApplicationMenu(menu)
