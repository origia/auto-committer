globalEvents = require '../js/browser/global-events'

angular.module 'GitodoApp', []

repoCtrl = require '../js/browser/controllers/repositories'

globalEvents.setup window
