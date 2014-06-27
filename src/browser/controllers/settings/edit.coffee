appSettings = require('../../../configuration/settings').app
gitSettings = require('../../../configuration/settings').git

settingsEditCtrl = ($scope) ->
  $scope.user = gitSettings.get('user') ? {}
  $scope.user.name ?= ''
  $scope.user.email ?= ''

  $scope.workspace = appSettings.get('workspace')

  $scope.save = ->
    gitSettings.save()
    appSettings.set('workspace', $scope.workspace)
    appSettings.save()


angular.module('GitodoApp').controller 'settingsEditCtrl', [
  '$scope', settingsEditCtrl
]
