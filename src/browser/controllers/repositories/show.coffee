_          = require 'underscore'

Repository = require('git-cli').Repository
db         = require '../../../configuration/database'


repoShowCtrl = ($scope, $stateParams, repository, tasks) ->
  $scope.repository = repository
  $scope.tasks = tasks

  $scope.nextTask = null

  $scope.getTasks = (type='all') ->
    switch type
      when 'all' then $scope.tasks.done.concat $scope.tasks.pending
      else $scope.tasks[type]

  $scope.setPage = (page) ->
    $scope.page = page


  isAuto = (email) ->
    # FIXME: hard coding
    email == 'auto.committer@gmail.com'

  $scope.updateTasks = ->
    [$scope.doneTasks, $scope.pendingTasks] = _.partition($scope.allTasks, (t) -> (t.done))

  $scope.updateTasks()


angular.module('GitodoApp').controller 'RepoShowCtrl', [
  '$scope', '$stateParams', 'repository', 'tasks', repoShowCtrl
]
