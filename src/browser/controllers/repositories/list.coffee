db     = require '../../../configuration/database'
ipc    = require 'ipc'

repoListCtrl = ($scope) ->
  $scope.repos = []

  db.repositories.find {}, (err, docs) ->
    $scope.$apply ->
      $scope.repos = docs

  $scope.createRepository = ->
    ipc.send 'open-modal', 'CreateRepo'


angular.module('GitodoApp').controller 'RepoListCtrl', [
  '$scope', repoListCtrl
]
