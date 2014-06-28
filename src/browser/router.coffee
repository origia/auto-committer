router = ($routeProvider) ->
  $routeProvider
    .when '/repositories',
      templateUrl: 'repositories/list.html'
      controller: 'RepoListCtrl'
    .when '/repositories/:id',
      templateUrl: 'repositories/show.html'
      controller: 'RepoShowCtrl'
    .otherwise
      redirectTo: '/repositories'

angular.module('GitodoApp').config ['$routeProvider', router]
