$   = require '../../../bower_components/jquery/dist/jquery.min.js'
remote = require 'remote'

exports.setup = (window) ->
  $(window).keypress (e) ->
    switch e.which
      when 18 then remote.getCurrentWindow().reload()
      when 20 then remote.getCurrentWindow().toggleDevTools()
      else return
