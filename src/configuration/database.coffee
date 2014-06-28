_           = require 'underscore'
Datastore   = require 'nedb'


appSettings = require('./settings').app

dataStores = [
  'repositories'
  'tasks'
]

db = {}

_.each dataStores, (store) ->
  db[store] = new Datastore(
    filename: "#{appSettings.configDir}/#{store}.db"
    autoload: true
  )

module.exports = db
