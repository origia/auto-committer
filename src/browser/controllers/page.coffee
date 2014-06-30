remote = require 'remote'
fs     = require 'fs'
path   = require 'path'
ipc    = require 'ipc'
spawn  = require('child_process').spawn

pageCtrl = ($scope, $location, $window) ->

  $scope.onKeypressed = (e) ->
    switch e.which
      when 18 then remote.getCurrentWindow().reload()
      when 20 then remote.getCurrentWindow().toggleDevTools()
      else return

  $scope.close = ->
    remote.getCurrentWindow().close()

  $scope.openDir = (fullPath) ->
    isFile = fs.statSync(fullPath).isFile()
    [command, args] = switch process.platform
      when 'darwin'
        args = if isFile then [fullPath, "-R"] else [fullPath]
        ['open', args]
      when 'win32', 'win64'
        ['explorer', [fullPath]]
      else
        fullPath = path.dirname(fullPath) if isFile
        ['xdg-open', [fullPath]]
    spawn command, args

  ipc.on 'change-page', (fullPath) ->
    $location.path fullPath


angular.module('GitodoApp').controller 'PageCtrl', [
  '$scope', '$location', '$window', pageCtrl
]
