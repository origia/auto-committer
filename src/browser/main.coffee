angular.module 'GitodoApp', [
  'ngRoute'
]

controllers = [
  'page'
  'repositories/list'
  'repositories/show'
  'repositories/new'
  'settings/edit'
]

for c in controllers
  require "../../js/browser/controllers/#{c}"

require "../../js/browser/router"
