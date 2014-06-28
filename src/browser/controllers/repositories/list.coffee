db = require '../../../configuration/database'

repoListCtrl = ($scope) ->
  $scope.repos = []

  db.repositories.find {}, (err, docs) ->
    $scope.$apply ->
      $scope.repos = docs


angular.module('GitodoApp').controller 'RepoListCtrl', [
  '$scope', repoListCtrl
]
