fs      = require 'fs-extra'
ini     = require 'ini'
path    = require 'path'

class GitSettings
  constructor: (@settingsFile) ->
    @settingsFile = path.join(@homeDir(), '.gitconfig') unless @settingsFile?
    @reload()

  reload: ->
    @config = ini.parse fs.readFileSync(@settingsFile, 'utf-8')

  homeDir: ->
    if process.platform == 'win32'
      process.env['USERPROFILE']
    else
      process.env['HOME']

  save: (makeBackup=false) ->
    serializedConfig = ini.stringify(@config)
    if makeBackup
      backupFile = @settingsFile + '.orig'
      fs.copySync @settingsFile, backupFile
    fs.writeFileSync @settingsFile, serializedConfig

module.exports = GitSettings
