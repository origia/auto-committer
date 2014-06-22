Menu = require 'menu'

exports.initMenu = (app) ->
  template = [
    label: 'AutoCommitter'
    submenu: [
      label: '設定'
      selector: 'settings:'
    ,
      label: '終了'
      accelerator: 'Command+Q',
      click: ( -> app.quit() )
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