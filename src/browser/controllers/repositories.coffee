repoCtrl = ($scope) ->
  $scope.repos = [
    title: 'foobar'
    path: '~/foobar'
    progress: 60
  ,
    title: 'auto-committer-nw'
    path: '~/Documents/auto-committer-nw'
    progress: 40
  ]

angular.module('GitodoApp').controller 'RepoCtrl', [
  '$scope', repoCtrl
]
