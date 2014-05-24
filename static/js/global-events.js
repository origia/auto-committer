(function() {
  var $, ipc;

  ipc = require('ipc');

  $ = require('../../bower_components/jquery/dist/jquery.min.js');

  $(window).keypress(function(e) {
    console.log(e.which);
    if (e.which === 116) {
      ipc.send('refresh');
      return console.log('foobar');
    }
  });

}).call(this);
