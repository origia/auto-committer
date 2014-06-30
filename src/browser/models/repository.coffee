_    = require 'underscore'
db   = require '../../configuration/database'
Repo = require('git-cli').Repository

class Repository extends Repo
  constructor: (args) ->
    throw new Error("needs a path") unless args.path?
    _.each args, (v, k) =>
      this[k] = v
    super "#{args.path}/.git"

  execIfChanged: (callback) ->
    @status
      onSuccess: (changes) =>
        if changes.length > 0
          @add
            onSuccess: =>
              callback()

  execIfChangedEnough: (threshold, callback) ->
    @execIfChanged =>
      @diffStats
        onSuccess: (stats) =>
          if stats.insertions + stats.deletions > threshold
            callback()
          else
            @diffStats
              cli: { cached: '' }
              onSuccess: (stats) =>
                if stats.insertions + stats.deletions > threshold
                  callback()

  backup: (message="") ->
    cli = {}
    if _.isEmpty(message)
      message = "自動バックアップ"
      cli.author = 'AutoCommitter <auto.committer@gmail.com>'
    @add
      onSuccess: =>
        @commit message, { cli: cli }

  updateTotalProgress: (tasks) ->
    tasksNumber = tasks.pending.length + tasks.done.length
    return 0 if tasksNumber == 0
    pendingSum  = _.reduce tasks.pending, (res, t) ->
      res + parseInt(t.progress, 10)
    , 0

    progressSum = pendingSum + tasks.done.length * 100
    @progress   = Math.floor(progressSum / tasksNumber)
    db.repositories.update { _id: @_id }, { $set: { progress: @progress } }


module.exports = Repository
