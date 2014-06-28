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
    .when '/settings',
      templateUrl: '../settings/edit.html'
      controller: 'SettingsEditCtrl'
    .otherwise
      redirectTo: '/repositories'

angular.module('GitodoApp').config ['$routeProvider', router]
