repoListCtrl = ($scope) ->
  $scope.repos = [
    title: 'foobar'
    path: '~/foobar'
    progress: 50
  ,
    title: 'auto-committer-nw'
    path: '~/Documents/auto-committer-nw'
    progress: 40
  ]

angular.module('GitodoApp').controller 'RepoListCtrl', [
  '$scope', repoListCtrl
]
