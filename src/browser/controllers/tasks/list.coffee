ipc = require 'ipc'
_   = require 'underscore'

db  = require '../../../configuration/database'
Repository = require('git-cli').Repository

Task = require '../../../browser/models/task'

removeDialog =
  type: 'warning'
  buttons: ['キャンセル', 'OK']
  title: '確認'
  message: 'このタスクを削除しますか？'

taskListCtrl = ($scope, $stateParams) ->
  $scope.setPage 'tasks-list'

  $scope.currentTask = null

  $scope.tasksType = 'all'

  updateCollections = ->
    allTasks = $scope.tasks.done.concat $scope.tasks.pending
    [$scope.tasks.done, $scope.tasks.pending] = _.partition(allTasks, (t) -> (t.done))

  removeTask = (task) ->
    _.each ['pending', 'done'], (type) ->
      $scope.tasks[type] = _.reject $scope.tasks[type], ((t) -> t._id == task._id)
    updateCollections()
    $scope.repository.updateTotalProgress($scope.tasks)

  commitProgress = (task, oldProgress, newProgress) ->
    # TODO: make commit message configurable
    commitMessage = "タスク'#{task.content}'が#{oldProgress}%から#{newProgress}%に更新されました。"

    $scope.repository.execIfChangedEnough 5, ->
      $scope.repository.backup commitMessage

  $scope.tryRemoveTask = ($event, task) ->
    $event.stopPropagation()
    response = ipc.sendSync 'show-message-dialog', removeDialog
    if response == 1
      $scope.currentTask = null if $scope.currentTask == task
      db.tasks.remove { _id: task._id }
      removeTask task
    else
      $scope.trySelectTask task

  $scope.saveMemo = ->
    return if _.isEmpty($scope.memoText)
    $scope.currentTask.memo = $scope.memoText
    $scope.currentTask.save()

  $scope.updateTaskProgress = ($event, task, percentage, restore) ->
    $event.stopPropagation()
    oldProgress = if task.done then 100 else task.oldProgress
    $scope.selectTask task
    task.updateProgress parseInt(percentage, 10), ->
      $scope.$apply ->
        updateCollections()
        $scope.repository.updateTotalProgress($scope.tasks)
        commitProgress task, oldProgress, task.progress

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
    task = new Task(
      content: $scope.newTaskText
      repository_id: $stateParams.id
    )
    task.save (err, task) ->
      $scope.$apply ->
        $scope.tasks.pending.push task
        $scope.newTaskText = ''
        $scope.repository.updateTotalProgress($scope.tasks)


angular.module('GitodoApp').controller 'TaskListCtrl', [
  '$scope', '$stateParams', taskListCtrl
]
