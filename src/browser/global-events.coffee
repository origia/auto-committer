ipc = require 'ipc'
$   = require '../../../bower_components/jquery/dist/jquery.min.js'

exports.setup = (window) ->
  $(window).keypress (e) ->
    switch e.which
      when 18 then ipc.send 'refresh'
      when 20 then ipc.send 'toggleTools'
      else return
