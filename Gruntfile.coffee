fs = require 'fs'

if process.platform == 'darwin'
  ATOM_PATH = './bin/Atom.app/Contents/MacOS/Atom'
else
  ATOM_PATH = './bin/atom'

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    watch:
      coffee:
        files: 'src/**/*.coffee'
        tasks: ['coffee:dist']
      sass:
        files: 'static/sass/**/*.scss'
        tasks: ['sass:dist']
      jade:
        files: 'views/**/*.jade'
        tasks: ['jade:dist']
      options:
        livereload: true

    exec:
      atom:
        command: ATOM_PATH + ' .'

    concurrent:
      dev:
        tasks: ['exec:atom', 'watch']
        options:
          logConcurrentOutput: true

    jade:
      dist:
        expand: true
        cwd: 'views'
        src: ['**/*.jade']
        dest: 'static/html'
        ext: '.html'

    sass:
      dist:
        files:
          'static/css/style.css': 'static/sass/style.scss'

    coffee:
      dist:
        expand: true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'static/js'
        ext: '.js'

    'download-atom-shell':
      version: '0.13.2'
      outputDir: './bin'

  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-exec'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-download-atom-shell'


  grunt.registerTask 'fix-permissions', ->
    fs.chmodSync ATOM_PATH, 0o755

  grunt.registerTask 'prepare', ['download-atom-shell', 'fix-permissions']

  grunt.registerTask 'compile', ['coffee:dist', 'sass:dist', 'jade:dist']

  grunt.registerTask 'default', ['compile', 'concurrent:dev']
