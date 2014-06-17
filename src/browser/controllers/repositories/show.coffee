repoShowCtrl = ($scope) ->
  $scope.editedFiles = [
    changeType: 'change'
    name: 'index.html'
    dirName: 'app/assets'
  ,
    changeType: 'add'
    name: 'style.css'
    dirName: 'app/assets'
  ,
    changeType: 'delete'
    name: 'test.html'
    dirName: 'app/assets'
  ,
    changeType: 'change'
    name: 'app.js'
    dirName: 'app/assets'
  ]

  $scope.fileDiff = [
    { type: 'unchanged', text: '<!DOCTYPE html>' },
    { type: 'unchanged', text: '<html>' },
    { type: 'plus', text: '<head>' },
    { type: 'plus', text: '<meta charset=”utf-8”>' },
    { type: 'plus', text: '<meta http-equiv=”X-UA-Compatible” content=”IE=edge”>' },
    { type: 'plus', text: '<title></title>' },
    { type: 'plus', text: '<link rel=”stylesheet” href=””>' },
    { type: 'plus', text: '<head>' },
    { type: 'minus', text: '<body>' }
  ]

angular.module('GitodoApp').controller 'RepoShowCtrl', [
  '$scope', repoShowCtrl
]
