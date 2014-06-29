_ = require 'underscore'
Repository = require('git-cli').Repository

db = require '../../../configuration/database'

repoShowCtrl = ($scope, $routeParams) ->
  $scope.nextTask = null
  $scope.page = 'commits-list'

  isAuto = (email) ->
    # FIXME: hard coding
    email == 'auto.committer@gmail.com'

  updateNextTask = ->
    n = $scope.pendingTasks.length
    return $scope.nextTask = null if n == 0
    taskIndex = Math.floor(Math.random() * n)
    $scope.nextTask = $scope.pendingTasks[taskIndex]
    taskValue = Math.round((100 - $scope.nextTask.progress) / $scope.tasks.length)
    $scope.nextProgress = $scope.repoInfo.progress + taskValue

  loadTasks = ->
    db.tasks.find { repository_id: $scope.repoInfo._id }, (err, docs) ->
      $scope.$apply ->
        $scope.tasks = docs
        [$scope.doneTasks, $scope.pendingTasks] = _.partition($scope.tasks, (t) -> (t.done))
        updateNextTask()

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
