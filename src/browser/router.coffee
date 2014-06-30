resolvers  = require './util/resolvers'

router = ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/repositories'

  $stateProvider
    .state 'repositories',
      url: '/repositories'
      templateUrl: '../repositories/list.html'
      controller: 'RepoListCtrl'
    .state 'repository',
      url: '/repositories/:id'
      templateUrl: '../repositories/show.html'
      controller: 'RepoShowCtrl'
      abstract: true
      resolve:
        repository: resolvers.resolveRepository
        tasks: resolvers.resolveTasks
    .state 'repository.commits',
      url: ''
      templateUrl: '../commits/list.html'
      controller: 'CommitListCtrl'
      resolve:
        commits: resolvers.resolveCommits
        next: resolvers.resolveNextTask
    .state 'repository.tasks',
      url: '/tasks'
      templateUrl: '../tasks/edit.html'
      controller: 'TaskListCtrl'
    .state 'settings',
      url: '/settings'
      templateUrl: '../settings/edit.html'
      controller: 'SettingsEditCtrl'
    .state 'create-repo',
      url: '/create-repo',
      templateUrl: '../repositories/new.html'
      controller: 'RepoNewCtrl'


angular.module('GitodoApp').config ['$stateProvider', '$urlRouterProvider', router]
