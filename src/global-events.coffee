ipc = require 'ipc'
$   = require '../../bower_components/jquery/dist/jquery.min.js'

$(window).keypress (e) ->
  console.log e.which
  if e.which == 116
    ipc.send 'refresh'
    console.log 'foobar'
