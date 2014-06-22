fs      = require 'fs-extra'
ini     = require 'ini'
path    = require 'path'
util    = require './util'

DEFAULT_PATH = path.join(util.homeDir(), '.gitconfig')

BaseSettings = require './base-settings'

class GitSettings extends BaseSettings
  constructor: (@settingsFile=DEFAULT_PATH) ->
    super @settingsFile

  serialize: ini.stringify
  deserialize: ini.parse


module.exports = GitSettings
