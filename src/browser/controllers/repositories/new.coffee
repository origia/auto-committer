_           = require 'underscore'
path        = require 'path'
ipc         = require 'ipc'
Repository  = require('git-cli').Repository

db          = require '../../../configuration/database'
appSettings = require('../../../configuration/settings').app

repoNewCtrl = ($scope) ->
  onCreateSuccess = (repo) ->
    newRepo = { path: repo.workingDir(), title: $scope.name, progress: 0, url: $scope.url }
    db.repositories.insert newRepo, (err, newDocs) ->
      # TODO: handle errors
      ipc.send 'refreshRepo'
      $scope.close()

  $scope.create = ->
    return unless $scope.name? && !_.isEmpty($scope.name)
    options = { onSuccess: onCreateSuccess }
    repoPath = path.join appSettings.get('workspace'), $scope.name
    if $scope.url? && !_.isEmpty($scope.url)
      $scope.loading = true
      Repository.clone $scope.url, repoPath, options
    else
      Repository.init repoPath, options

  $scope.$watch 'url', ->
    return unless $scope.url? && !_.isEmpty($scope.url)
    $scope.name = path.basename $scope.url, '.git'

angular.module('GitodoApp').controller 'RepoNewCtrl', [
  '$scope', repoNewCtrl
]
