router = ($routeProvider) ->
  $routeProvider
    .when '/repositories',
      templateUrl: '../repositories/list.html'
      controller: 'RepoListCtrl'
    .when '/repositories/:id',
      templateUrl: '../repositories/show.html'
      controller: 'RepoShowCtrl'
    .when '/repositories/:id/tasks',
      templateUrl: '../tasks/edit.html'
      controller: 'TaskListCtrl'
    .when '/settings',
      templateUrl: '../settings/edit.html'
      controller: 'SettingsEditCtrl'
    .when '/create-repo',
      templateUrl: '../repositories/new.html'
      controller: 'RepoNewCtrl'
    .otherwise
      redirectTo: '/repositories'

angular.module('GitodoApp').config ['$routeProvider', router]
