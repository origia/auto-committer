_          = require 'underscore'

Repository = require '../browser/models/repository'
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
      @repositories = (new Repository(d) for d in docs)

  checkForChanges: ->
    _.each @repositories, (r) =>
      r.execIfChangedEnough 30, ->
        r.backup()


module.exports = RepoListener
