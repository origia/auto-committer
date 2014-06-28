var path = require('path')
 ,  db = require(path.join(__dirname, '..', 'static', 'js', 'configuration', 'database'))

db.repositories.insert([{
    title: "foobar"
  , path: "~/Documents/foobar"
  , progress: 50
  }, {
    title: "auto-committer"
  , path: "~/Documents/auto-committer"
  , progress: 35
  }], function (err, newDocs) {
})
