_          = require 'underscore'
db         = require '../../configuration/database'
Task       = require '../../browser/models/task'
Repository = require('git-cli').Repository



exports.resolveRepository = ($q, $stateParams) ->
  deferred = $q.defer()
  db.repositories.findOne {_id: $stateParams.id }, (err, doc) ->
    deferred.resolve
      info: doc
      obj: new Repository(doc.path + '/.git')
  deferred.promise

exports.resolveTasks = ($q, $stateParams) ->
  deferred = $q.defer()
  db.tasks.find { repository_id: $stateParams.id }, (err, tasks) ->
    tasks = _.map(tasks, (t) -> new Task(t))
    [doneTasks, pendingTasks] = _.partition(tasks, (t) -> (t.done))
    deferred.resolve
      done: doneTasks
      pending: pendingTasks
  deferred.promise

exports.resolveCommits = (repository, $q) ->
  deferred = $q.defer()
  repository.obj.log
    onSuccess: (commits) ->
      deferred.resolve commits
  deferred.promise

exports.resolveNextTask = (tasks, repository) ->
  n = tasks.pending.length
  return { task: null, progress: 0 } if n == 0
  taskIndex = Math.floor(Math.random() * n)
  nextTask = tasks.pending[taskIndex]
  taskValue = Math.round((100 - nextTask.progress) / (n + tasks.done.length))
  nextProgress = Math.min(repository.info.progress + taskValue, 100)
  return {
    task: nextTask
    progress: nextProgress
  }
