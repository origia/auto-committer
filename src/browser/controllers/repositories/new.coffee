_           = require 'underscore'
path        = require 'path'

Repository  = require('git-cli').Repository
appSettings = require('../../../configuration/settings').app

repoNewCtrl = ($scope) ->
  onCreateSuccess = (repo) ->
    console.log repo

  $scope.create = ->
    return unless $scope.name? && !_.isEmpty($scope.name)
    options = { onSucces: onCreateSuccess }
    repoPath = path.join appSettings.get('workspace'), $scope.name
    if $scope.url? && !_.isEmpty($scope.url)
      Repository.clone $scope.url, repoPath, options
    else
      Repository.init repoPath, options


angular.module('GitodoApp').controller 'RepoNewCtrl', [
  '$scope', repoNewCtrl
]
