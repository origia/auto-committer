Menu = require 'menu'
modals = require './modals'

exports.initMenu = (app) ->
  template = [
    label: 'AutoCommitter'
    submenu: [
      label: 'AutoCommitter について',
      selector: 'orderFrontStandardAboutPanel:'
    ,
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
  ,
    label: 'ファイル'
    submenu: [
      label: '新しいプロジェクトを作成',
      accelerator: 'Command+N',
      selector: 'createProject:'
    ,
    {
      type: 'separator'
    }
    ,
      label: 'ウインドウを閉じる',
      accelerator: 'Command+W',
      selector: 'performClose:'
    ]
  ,
    label: '編集'
    submenu: [
      label: '取り消す',
      accelerator: 'Command+Z',
      selector: 'undo:'
    ,
      label: 'やり直す',
      accelerator: 'Shift+Command+Z',
      selector: 'redo:'
    ,
    {
      type: 'separator'
    }
    ,
      label: '切り取り',
      accelerator: 'Command+X',
      selector: 'cut:'
    ,
      label: 'コピー',
      accelerator: 'Command+C',
      selector: 'copy:'
    ,
      label: '貼り付け',
      accelerator: 'Command+V',
      selector: 'paste:'
    ,
      label: 'すべてを選択',
      accelerator: 'Command+A',
      selector: 'selectAll:'
    ]
  ,
    label: '表示'
    submenu: [
      label: '再表示',
      accelerator: 'Command+R',
      click: ( -> BrowserWindow.getFocusedWindow().reloadIgnoringCache() )
    ,
    {
      type: 'separator'
    }
    ,
      label: 'デベロッパーツールを開く',
      accelerator: 'Alt+Command+I',
      click: ( -> BrowserWindow.getFocusedWindow().toggleDevTools() )
    ]
  ,
    label: 'ウインドウ'
    submenu: [
      label: '最小化',
      accelerator: 'Command+M',
      selector: 'performMiniaturize:'
    ]
  ]

  menu = Menu.buildFromTemplate(template)
  Menu.setApplicationMenu(menu)
