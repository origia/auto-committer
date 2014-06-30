commitListCtrl = ($scope, commits, next) ->
  $scope.setPage 'commits-list'
  $scope.commits = commits
  $scope.next = next

angular.module('GitodoApp').controller 'CommitListCtrl', [
  '$scope', 'commits', 'next', commitListCtrl
]
