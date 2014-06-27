Sequelize = require 'sequelize'
db        = require '../configuration/database'

Repository = db.define 'Repository',
  name: Sequelize.STRING
  path: Sequelize.STRING
  progress: Sequelize.INTEGER.UNSIGNED

module.exports = Repository
