_           = require 'underscore'
Datastore   = require 'nedb'


appSettings = require('./settings').app

dataStores = [
  'repositories'
]

db = {}

_.each dataStores, (store) ->
  db[store] = new Datastore(
    filename: "#{appSettings.configDir}/#{store}.db"
  )

module.exports = db
