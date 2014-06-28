angular.module 'GitodoApp', []

controllers = [
  'page'
  'repositories/list'
  'repositories/show'
  'settings/edit'
]

for c in controllers
  require "../../js/browser/controllers/#{c}"

