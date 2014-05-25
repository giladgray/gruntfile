"use strict"

# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt) ->
  pkg = grunt.file.readJSON('package.json')

  # load all grunt tasks
  require('load-grunt-tasks') grunt
  require('time-grunt') grunt

  ###### PLUGIN CONFIGURATIONS ######
  grunt.initConfig
    watch:
      template:
        files: ['app/_*']
        tasks: ['template']
      browserify:
        files: 'app/scripts/{,*/}*.coffee'
        tasks: ['browserify']
      handlebars:
        files: ['app/templates/{,*/}*.hbs']
        tasks: ['handlebars']
      sass:
        files: ['app/styles/{,*/}*.{scss,sass}']
        tasks: ['sass'] #, 'autoprefixer']
      livereload:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: ['dist/**/*.{js,css,html,json,png}']

    clean:
      dist: ['dist']

    browserify:
      options:
        transform: ['coffeeify']
      main:
        files:
          'dist/scripts/index.js': ['app/scripts/index.coffee']

    sass:
      dist:
        options:
          style: 'compact'
        files: [
          expand: true
          cwd: 'app/styles'
          src: '*.{scss,sass}'
          dest: 'dist/styles'
          ext: '.css'
        ]

    handlebars:
      dist:
        files:
          'dist/scripts/templates.js': ['app/templates/{,*/}*.hbs']
        options:
          namespace: 'Templates'
          processName: (filename) ->
            filename.match(/templates\/(.+)\.h[bj]s$/)[1]

    template:
      dist:
        options:
          data: pkg
        files:
          'dist/index.html'   : ['app/_index.html']
          'dist/manifest.json': ['app/_manifest.json']

    copy:
      dist:
        files: [
          {expand: true, cwd: 'app', src: ['styles/fonts/**'], dest: 'dist'},
        ]

    imagemin:
      dist:
        expand: true
        cwd: 'app'
        src: ['images/*.png']
        dest: 'dist'

    useminPrepare:
      html: 'app/_index.html'

    usemin:
      options:
        dirs: ['dist']
      html: ['dist/{,*/}*.html']

    # The actual grunt server settings
    connect:
      options:
        port: 9000
        livereload: 35729
        # Change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'
      livereload:
        options:
          open: true
          base: ['app', 'dist', 'node_modules']
      test:
        options:
          port: 9001
          base: ['app', 'dist', 'test']
      dist:
        options:
          open: true
          base: 'dist'
          livereload: false
      github:
        options:
          open: 'https://giladgray.github.io/mmindd-mmvp'

    'gh-pages':
      options:
        base: 'dist'
      src: ['**']

  ######### TASK DEFINITIONS #########

  # compile assets for development
  grunt.registerTask 'build', [
    'clean'
    'sass'
    'handlebars'
    'browserify'
    'copy'
    'template'
  ]

  # build, dev server, watch
  grunt.registerTask 'dev', [
    'build'
    'connect:livereload'
    'watch'
  ]

  # compress and obfuscate files for production
  grunt.registerTask 'minify', [
    'imagemin'
    'useminPrepare'
    'concat'
    'uglify'
    'cssmin'
    'usemin'
  ]

  # build, minify, copy production assets
  grunt.registerTask 'dist', [
    'build',
    'minify',
    'copy',
    'connect:dist:keepalive'
  ]

  # publish dist/ directory to github and open page
  grunt.registerTask 'deploy', [
    'gh-pages'
    'connect:github'
  ]

  grunt.registerTask 'default', ['dev']
