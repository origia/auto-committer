fs      = require 'fs-extra'
path    = require 'path'
_       = require 'underscore'
util    = require './../backend/util'

BaseSettings = require './base-settings'

CONFIG_DIR  = path.join util.homeDir(), '.auto-committer'
CONFIG_FILE = path.join CONFIG_DIR, 'settings.json'

fs.ensureDirSync CONFIG_DIR

unless fs.existsSync CONFIG_FILE
  BASE_CONFIG_FILE = path.join __dirname, '..', '..', '..', 'config', 'default_settings.json'
  fs.copySync BASE_CONFIG_FILE, CONFIG_FILE


class AppSettings extends BaseSettings
  constructor: (@settingsFile=CONFIG_FILE) ->
    super @settingsFile
    @configDir = path.dirname CONFIG_FILE

  serialize: (s) -> JSON.stringify s, null, '  '
  deserialize: JSON.parse

  _extract: (value) ->
    return value unless _.isString(value)
    value.replace '$HOME', util.homeDir()


module.exports = AppSettings
