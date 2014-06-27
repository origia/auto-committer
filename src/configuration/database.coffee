appSettings = require('./settings').app
Sequelize   = require 'sequelize'

db = new Sequelize('auto_committer', null, null, {
  dialect: 'sqlite'
  storage: "#{appSettings.configDir}/app.db"
})

module.exports = db
