commitListCtrl = ($scope, commits, next) ->
  $scope.setPage 'commits-list'
  $scope.commits = commits
  $scope.next = next


  $scope.openText = switch process.platform
    when 'darwin' then 'このプロジェクトをFinderで開く'
    when 'win32', 'win64' then 'このプロジェクトをExplorerで開く'
    else 'このプロジェクトを開く'

angular.module('GitodoApp').controller 'CommitListCtrl', [
  '$scope', 'commits', 'next', commitListCtrl
]
