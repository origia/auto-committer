db        = require '../configuration/database'

BaseModel = require './base-model'

class Repository extends BaseModel
  constructor: (@args={}) ->
    super

module.exports = Repository
