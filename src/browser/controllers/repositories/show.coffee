_ = require 'underscore'
Repository = require('git-cli').Repository

db = require '../../../configuration/database'

repoShowCtrl = ($scope, $routeParams) ->

  isAuto = (email) ->
    # FIXME: hard coding
    email == 'auto.committer@gmail.com'

  loadTasks = ->
    db.tasks.find { repository_id: $scope.repoInfo._id }, (err, docs) ->
      $scope.$apply ->
        $scope.tasks = docs
        [$scope.doneTasks, $scope.pendingTasks] = _.partition($scope.tasks, (t) -> (t.done))

  loadLogs = ->
    $scope.repo.log
      onSuccess: (commits) ->
        $scope.$apply ->
          $scope.commits = commits

  loadRepository = ->
    db.repositories.findOne {_id: $routeParams.id }, (err, doc) ->
      $scope.$apply ->
        $scope.repoInfo = doc
        $scope.repo = new Repository($scope.repoInfo.path + '/.git')
        loadTasks()
        loadLogs()


  loadRepository()

angular.module('GitodoApp').controller 'RepoShowCtrl', [
  '$scope', '$routeParams', repoShowCtrl
]
