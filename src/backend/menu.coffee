Menu = require 'menu'

template = [
  label: 'AutoCommitter'
  submenu: [
    label: '設定'
    selector: 'settings:'
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
