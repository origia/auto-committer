

function createRepository(){
	//alert("createRepository");
	showCreateWindow();
}

function cloneRepository(){
	alert("cloneRepository");
}

function showCreateWindow(){
	var cWindow = $(
		'<div class="filter"></div><div class="create-window"><ul>'
		+	'<li>リポジトリ名：<input type="text" name="repository"></li>'
		+	'<li>ブックマーク名：<input type="text" name="bookmark"></li>'
		+	'<li>保存先のパス：<input type="text" name="path"></li>'
		+	'</ul>'
		+ 	'<div><input type="button" value="キャンセル">'
		+	'<input type="submit" value="新規作成"></div></div>');
	var win = document.getElementById("main");
	cWindow.appendTo(win);
}

var repository = new Repository('/home/daniel/foobar');
repository.startWatch();
setInterval(function() {
	repository.commit();
	repository.push();
}, 5000);
console.log('start watching');
// repository.commit();
// repository.push();
