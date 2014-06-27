_  = require 'underscore'
_.mixin(require('underscore.string').exports())

db = require '../configuration/database'

class BaseModel
  @dbName: ->
    @prototype.constructor.name

  constructor: (@args={}) ->
    className = @constructor.name
    normalizedName = _.underscored[className]
    @db = db[normalizedName]
    @_id = null

  @create: (args={}, options={}) ->
    item = new @prototype.constructor(args)
    item.save(options)

  _insertCallback: (err, doc) =>
    unless err?
      @_id = doc[0]._id
      if options.onSuccess?
        options.onSuccess this
    else
      if options.onError?
        options.onError err

  save: (options = {}) ->
    if @_id?
      @db.update({ _id: @_id }, $set: @args)
    else
      @db.insert @args, @_insertCallback

module.exports = BaseModel
