globalEvents = require '../../js/browser/global-events'

angular.module 'GitodoApp', []

controllers = [
  'repositories/list'
  'repositories/show'
  'settings/edit'
]

for c in controllers
  require "../../js/browser/controllers/#{c}"

globalEvents.setup window
