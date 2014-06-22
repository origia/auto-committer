fs      = require 'fs-extra'
path    = require 'path'
_       = require 'underscore'
util    = require './util'

BaseSettings = require './base-settings'

CONFIG_FILE = path.join(__dirname, '..', '..', '..', 'config', 'settings.json')

class AppSettings extends BaseSettings
  constructor: (@settingsFile=CONFIG_FILE) ->
    super @settingsFile

  serialize: (s) -> JSON.stringify s, null, '  '
  deserialize: JSON.parse

  _extract: (value) ->
    return value unless _.isString(value)
    value.replace '$HOME', util.homeDir()


module.exports = AppSettings
