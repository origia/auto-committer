_          = require 'underscore'

Repository = require('git-cli').Repository
db         = require '../configuration/database'

class RepoListener
  constructor: (options={}) ->
    @repositories = []
    @isStarted = false
    @reload()
    @start() if options.autoStart

  start: ->
    return if @isStarted
    @isStarted = true
    @interval = setInterval (=> @checkForChanges()), 1000

  stop: ->
    return unless @isStarted
    @isStarted = false
    clearInterval @interval

  reload: ->
    db.repositories.find {}, (err, docs) =>
      @repositories = (new Repository("#{d.path}/.git") for d in docs)

  autoBackup: (r) ->
    r.add
      onSuccess: ->
        r.commit "自動バックアップ",
          cli: { author: 'AutoCommitter <auto.committer@gmail.com>' }

  tryBackup: (r) ->
    r.diffStats
      onSuccess: (stats) =>
        if stats.insertions + stats.deletions > 30
          autoBackup r
        else
          r.diffStats
            cli: { cached: '' }
            onSuccess: (stats) =>
              if stats.insertions + stats.deletions > 30
                @autoBackup r

  checkForChanges: ->
    _.each @repositories, (r) =>
      r.status
        onSuccess: (changes) =>
          if changes.length > 0
            r.add
              onSuccess: =>
                @tryBackup r


module.exports = RepoListener
