fs      = require 'fs-extra'

class BaseSettings
  constructor: (@settingsFile) ->
    @reload()

  reload: ->
    @config = @deserialize fs.readFileSync(@settingsFile, 'utf-8')

  save: (makeBackup=false) ->
    serializedConfig = @serialize @config
    if makeBackup
      backupFile = @settingsFile + '.orig'
      fs.copySync @settingsFile, backupFile
    fs.writeFileSync @settingsFile, serializedConfig

  get: (keys) ->
    keys = keys.split '.'
    conf = @config
    for key in keys
      conf = conf[key]
    @_extract conf

  set: (keys, value) ->
    [confKeys..., key] = keys.split '.'
    conf = @config
    for k in confKeys
      conf[k] = {} unless conf[k]?
      conf = conf[k]
    conf[key] = value

  remove: (keys) ->
    @set keys, undefined

  _extract: (value) -> value

module.exports = BaseSettings
