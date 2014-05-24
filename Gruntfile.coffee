module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    watch:
      coffee :
        files: 'src/*.coffee'
        tasks: ['coffee:dist']

      sass:
        files: 'static/sass/*.scss'
        tasks: ['sass:dist']

      jade:
        files: 'views/*.jade'
        tasks: ['jade:dist']

    exec:
      atom:
        command: 'atom-shell .'

    concurrent:
      dev:
        tasks: ['exec:atom', 'watch']
        options:
          logConcurrentOutput: true

    jade:
      dist:
        files:
          "static/html/index.html": ["views/index.jade"]

    sass:
      dist:
        files:
          'static/css/style.css': 'static/sass/style.scss'

    coffee:
      dist:
        files:
          'static/js/gitodo.js': 'src/gitodo.coffee'
          'static/js/app.js': 'src/app.coffee'
          'static/js/global-events.js': 'src/global-events.coffee'

  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-exec'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.registerTask 'compile', ['coffee:dist', 'sass:dist', 'jade:dist']

  grunt.registerTask 'default', ['compile', 'concurrent:dev']
