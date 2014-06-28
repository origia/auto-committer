angular.module 'GitodoApp', [
  'ngRoute'
  'ui.gravatar'
]

controllers = [
  'page'
  'repositories/list'
  'repositories/show'
  'repositories/new'
  'settings/edit'
  'tasks/list'
]

for c in controllers
  require "../../js/browser/controllers/#{c}"

require "../../js/browser/router"
