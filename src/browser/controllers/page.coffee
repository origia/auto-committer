remote = require 'remote'

pageCtrl = ($scope) ->

  $scope.onKeypressed = (e) ->
    switch e.which
      when 18 then remote.getCurrentWindow().reload()
      when 20 then remote.getCurrentWindow().toggleDevTools()
      else return


angular.module('GitodoApp').controller 'PageCtrl', [
  '$scope', pageCtrl
]
