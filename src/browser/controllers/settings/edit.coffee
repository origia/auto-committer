GitSettings = require '../../../backend/git-settings'
AppSettings = require '../../../backend/app-settings'

settingsEditCtrl = ($scope) ->
  gitSettings = new GitSettings()
  appSettings = new AppSettings()

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
