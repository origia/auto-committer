angular.module 'GitodoApp', [
  'ngRoute'
  'ui.gravatar'
  'ui.router'
]

controllers = [
  'page'
  'repositories/list'
  'repositories/show'
  'repositories/new'
  'commits/list'
  'settings/edit'
  'tasks/list'
]

for c in controllers
  require "../../js/browser/controllers/#{c}"

require "../../js/browser/router"
