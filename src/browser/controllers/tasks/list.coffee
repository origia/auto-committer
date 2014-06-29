_      = require 'underscore'
db     = require '../../../configuration/database'

taskListCtrl = ($scope, $routeParams) ->
  $scope.tasks = []
  repoId = $routeParams.id

  $scope.currentTask = null

  $scope.tasksType = 'all'

  updateCollections = ->
    [$scope.doneTasks, $scope.pendingTasks] = _.partition($scope.tasks, (t) -> (t.done))

  $scope.filterTasks = (type) ->
    $scope.tasksType = type
    switch type
      when 'all' then $scope.tasks = $scope.allTasks
      when 'pending' then $scope.tasks = $scope.pendingTasks
      when 'done' then $scope.tasks = $scope.doneTasks


  loadRepository = ->
    db.repositories.findOne {_id: $routeParams.id }, (err, doc) ->
      $scope.$apply ->
        $scope.repoInfo = doc

  loadTasks = ->
    db.tasks.find { repository_id: repoId }, (err, tasks) ->
      $scope.$apply ->
        $scope.allTasks = tasks
        $scope.tasks = $scope.allTasks
        updateCollections()
        loadRepository()


  $scope.saveMemo = ->
    return if _.isEmpty($scope.memoText)
    $scope.currentTask.memo = $scope.memoText
    db.tasks.update { _id: $scope.currentTask._id }, { $set: { memo: $scope.memoText } }

  $scope.updateTaskProgress = ($event, task, percentage, restore) ->
    $event.stopPropagation()
    $scope.selectTask task
    if not restore
      task.oldProgress = task.progress
    if task.done && restore
      task.progress = task.oldProgress
    else
      task.oldProgress = task.progress
      task.progress = percentage
    task.done = task.progress == 100
    newAttrs = _.pick(task, 'oldProgress', 'progress', 'done')
    db.tasks.update { _id: task._id }, { $set: newAttrs }, ->
      $scope.$apply ->
        updateCollections()


  $scope.trySubmit = (e) ->
    $scope.saveTask() if e.which == 13

  $scope.selectTask = (task) ->
    $scope.currentTask = task
    $scope.memoText = task.memo

  $scope.trySelectTask = (task) ->
    if $scope.currentTask == task
      $scope.unselectTask()
    else
      $scope.selectTask task

  $scope.unselectTask = ->
    $scope.currentTask = null

  $scope.saveTask = ->
    return if !$scope.newTaskText? or _.isEmpty($scope.newTaskText)
    newTask =
      content: $scope.newTaskText
      oldProgress: 0
      progress: 0
      memo: ''
      createdAt: new Date()
      repository_id: repoId
      done: false
    db.tasks.insert newTask, (err, task) ->
      $scope.$apply ->
        $scope.tasks.push task
        $scope.newTaskText = ''

  loadTasks()


angular.module('GitodoApp').controller 'TaskListCtrl', [
  '$scope', '$routeParams', taskListCtrl
]
