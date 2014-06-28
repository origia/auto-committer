remote = require 'remote'
ipc    = require 'ipc'

pageCtrl = ($scope, $location) ->

  $scope.onKeypressed = (e) ->
    switch e.which
      when 18 then remote.getCurrentWindow().reload()
      when 20 then remote.getCurrentWindow().toggleDevTools()
      else return

  $scope.close = ->
    remote.getCurrentWindow().close()

  ipc.on 'change-page', (path) ->
    $location.path path


angular.module('GitodoApp').controller 'PageCtrl', [
  '$scope', '$location', pageCtrl
]
