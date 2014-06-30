_   = require 'underscore'
db  = require '../../configuration/database'

class Task
  @fields = ['content', 'oldProgress', 'progress', 'memo', 'createdAt', 'done', 'repository_id']

  @defaults: ->
    content: ''
    oldProgress: 0
    progress: 0
    memo: ''
    createdAt: new Date()
    done: false

  constructor: (args={}) ->
    args = _.extend {}, Task.defaults(), args
    _.each args, (v, k) =>
      this[k] = v
    throw new Error('needs repository id') unless @repository_id?

  save: (callback) ->
    attrs = _.pick this, Task.fields...
    if @_id
      db.tasks.update { _id: @_id}, { $set: attrs }, (err, task) =>
        callback(err, task) if callback?
    else
      db.tasks.insert attrs, (err, task) =>
        @_id = task._id
        callback(err, task) if callback?

  updateProgress: (percentage, callback) =>
    doBackup = percentage != 100
    @oldProgress = @progress if doBackup

    if @done && !doBackup
      @progress = @oldProgress
    else
      @oldProgress = @progress
      @progress = percentage
    @done = @progress == 100

    @save callback


module.exports = Task
