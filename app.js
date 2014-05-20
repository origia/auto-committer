// var Repository = require('auto-committer-backend');
// function createRepository(){
// 	showCreateWindow();
// }
// function cloneRepository(){
// 	alert("cloneRepository");
// }
// function showCreateWindow(){
// 	var cWindow = $();
// 	var win = document.getElementById("main");
// 	cWindow.appendTo(win);
// 	$(function(){
// 		$("#modal").show("fast");
// 		$("nav .create").css('background', 'url(images/common/nav-selected.png) no-repeat');
// 		$(".create-window input.repository").focus();
// 	})
// }
// function cancelCreateRepository() {
// 	$(function(){
// 		$("#modal").hide();
// 		$("nav .create").css('background', 'none');
// 	})
// }

// // repository.commit();
// // repository.push();

// function showValue () {
// 	document.getElementById("showRangeArea").innerHTML = document.getElementById("todoProgress").value;
// }

var app = require('app');  // Module to control application life.
var BrowserWindow = require('browser-window');  // Module to create native browser window.

// Report crashes to our server.
require('crash-reporter').start();

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the javascript object is GCed.
var mainWindow = null;

// Quit when all windows are closed.
app.on('window-all-closed', function() {
  if (process.platform != 'darwin')
    app.quit();
});

// This method will be called when atom-shell has done everything
// initialization and ready for creating browser windows.
app.on('ready', function() {
  // Create the browser window.
  mainWindow = new BrowserWindow({width: 800, height: 600});

  // and load the index.html of the app.
  mainWindow.loadUrl('file://' + __dirname + '/manage.html');
  mainWindow.toggleDevTools();

  // Emitted when the window is closed.
  mainWindow.on('closed', function() {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    mainWindow = null;
  });
});
