appSettings = require('settings.coffee').app
Sequelize   = require 'sequelize'

require '../models'

db = new Sequelize('auto_committer', null, null, {
  dialect: 'sqlite'
  storage: "#{appSettings.configDir}"
})

module.exports = db