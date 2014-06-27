AppSettings = require './app-settings'
GitSettings = require './git-settings'

module.exports =
  app: new AppSettings()
  git: new GitSettings()
