module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    watch:
      coffee :
        files: 'src/*.coffee'
        tasks: ['coffee:compile']

      sass:
        files: 'static/sass/*.scss'
        tasks: ['sass:dist']

      jade:
        files: 'views/*.jade'
        tasks: ['jade:compile']

    exec:
      atom:
        command: 'atom-shell .'

    concurrent:
      dev:
        tasks: ['exec:atom', 'watch']
        options:
          logConcurrentOutput: true

    jade:
      compile:
        files:
          "static/html/index.html": ["views/index.jade"]

    sass:
      dist:
        files:
          'static/css/style.css': 'static/sass/style.scss'

    coffee:
      compile:
        files:
          'static/js/app.js': 'src/app.coffee'

  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-exec'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.registerTask 'default', ['concurrent:dev']
