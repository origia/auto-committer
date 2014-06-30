_          = require 'underscore'
Repository = require('git-cli').Repository

db         = require '../../../configuration/database'
ipc        = require 'ipc'


repoListCtrl = ($scope, $interval) ->
  $scope.repos = []

  loadRepos = ->
    db.repositories.find {}, (err, docs) ->
      $scope.$apply ->
        $scope.repos = docs

  ipc.on 'refreshRepo', ->
    db.repositories.loadDatabase()
    loadRepos()

  $scope.createRepository = ->
    ipc.send 'open-modal', 'CreateRepo'

  loadRepos()


angular.module('GitodoApp').controller 'RepoListCtrl', [
  '$scope', '$interval', repoListCtrl
]
