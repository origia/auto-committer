_          = require 'underscore'
Repository = require('git-cli').Repository

db         = require '../../../configuration/database'
ipc        = require 'ipc'

interval = null

repoListCtrl = ($scope, $interval) ->
  $scope.repos = []

  autoBackup = (r) ->
    r.add
      onSuccess: ->
        r.commit "自動バックアップ",
          cli: { author: 'AutoCommitter <auto.committer@gmail.com>' }

  tryBackup = (r) ->
    r.diffStats
      onSuccess: (stats) ->
        if stats.insertions + stats.deletions > 30
          autoBackup r
        else
          r.diffStats
            cli: { cached: '' }
            onSuccess: (stats) ->
              if stats.insertions + stats.deletions > 30
                autoBackup r

  checkForChanges = ->
    _.each $scope.repos, (repo) ->
      r = new Repository("#{repo.path}/.git")
      r.status
        onSuccess: (changes) ->
          if changes.length > 0
            r.add
              onSuccess: ->
                tryBackup r

  ipc.on 'refreshRepo', ->
    db.repositories.loadDatabase()
    loadRepos()

  loadRepos = ->
    db.repositories.find {}, (err, docs) ->
      $scope.$apply ->
        $scope.repos = docs

  $scope.createRepository = ->
    ipc.send 'open-modal', 'CreateRepo'

  unless interval?
    interval = $interval checkForChanges, 10000

  loadRepos()


angular.module('GitodoApp').controller 'RepoListCtrl', [
  '$scope', '$interval', repoListCtrl
]
