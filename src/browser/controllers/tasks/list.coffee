ipc = require 'ipc'
_   = require 'underscore'

db  = require '../../../configuration/database'

taskListCtrl = ($scope, $routeParams) ->
  $scope.tasks = []
  repoId = $routeParams.id

  $scope.currentTask = null

  $scope.tasksType = 'all'

  updateCollections = ->
    [$scope.doneTasks, $scope.pendingTasks] = _.partition($scope.allTasks, (t) -> (t.done))
    $scope.filterTasks $scope.tasksType

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

  removeTask = (task) ->
    $scope.allTasks = _.reject $scope.allTasks, ((t) -> t._id == task._id)
    updateCollections()

  $scope.tryRemoveTask = ($event, task) ->
    $event.stopPropagation()
    response = ipc.sendSync 'show-message-dialog',
      type: 'warning'
      buttons: ['キャンセル', 'OK']
      title: '確認'
      message: 'このタスクを削除しますか？'
    if response == 1
      if $scope.currentTask == task
        $scope.currentTask = null
      db.tasks.remove { _id: task._id }
      removeTask task
    else
      $scope.trySelectTask task

  $scope.saveMemo = ->
    return if _.isEmpty($scope.memoText)
    $scope.currentTask.memo = $scope.memoText
    db.tasks.update { _id: $scope.currentTask._id }, { $set: { memo: $scope.memoText } }

  updateTotalProgress = ->
    total       = $scope.allTasks.length
    progressSum = _.reduce $scope.allTasks, ((res, t) -> res + parseInt(t.progress, 10)), 0
    progress = Math.floor(progressSum / total)
    db.repositories.update { _id: $scope.repoInfo._id }, { $set: { progress: progress } }


  $scope.updateTaskProgress = ($event, task, percentage, restore) ->
    $event.stopPropagation()
    percentage = parseInt(percentage, 10)
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
      updateTotalProgress()
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
