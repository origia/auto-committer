Menu = require 'menu'

template = [
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
