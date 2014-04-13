var Repository = require('auto-committer-backend');

function createRepository(){
	//alert("createRepository");
	showCreateWindow();
}

function cloneRepository(){
	alert("cloneRepository");
}

function showCreateWindow(){
	var cWindow = $();
	var win = document.getElementById("main");
	cWindow.appendTo(win);
	$(function(){
		$("#modal").show();
		$("nav .create").css('background', 'url(images/common/nav-selected.png) no-repeat');
	})
}

function cancelCreateRepository() {
	$(function(){
		$("#modal").hide();
		$("nav .create").css('background', 'none');
	})
}

var repository = new Repository('/home/daniel/foobar');
repository.startWatch();
setInterval(function() {
  repository.diffStats(function (stats) {
    console.log(stats);
    if (stats.insertionsNumber > 0 || stats.deletionsNumber > 0) {
      repository.commit();
      repository.push();
    }
  })

}, 5000);
console.log('start watching');
// repository.commit();
// repository.push();
