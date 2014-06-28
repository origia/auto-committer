db     = require '../../../configuration/database'
ipc    = require 'ipc'

repoListCtrl = ($scope) ->
  $scope.repos = []

  ipc.on 'refreshRepo', ->
    db.repositories.loadDatabase()
    loadRepos()

  loadRepos = ->
    db.repositories.find {}, (err, docs) ->
      $scope.$apply ->
        $scope.repos = docs

  $scope.createRepository = ->
    ipc.send 'open-modal', 'CreateRepo'

  loadRepos()


angular.module('GitodoApp').controller 'RepoListCtrl', [
  '$scope', repoListCtrl
]
