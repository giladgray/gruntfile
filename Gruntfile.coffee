"use strict"

_ = require 'lodash'

DEFAULT_OPTIONS =
  paths: # UNIMPLEMENTED
    app  : 'app'
    temp : '.tmp'
    dist : 'dist'
  scripts   : ['scripts/**/*.coffee']
  styles    : ['styles/**/*.{scss,sass}']
  templates : ['templates/**/*.hbs']
  assets    : ['index.html', 'scripts/styles/fonts/**']
  overrides: {} # UNIMPLEMENTED / UNTESTED

###
Installation commands:
npm install --save-dev grunt browserify coffeeify load-grunt-tasks time-grunt
npm install --save-dev grunt-browserify grunt-contrib-clean grunt-contrib-concat grunt-contrib-connect grunt-contrib-copy grunt-contrib-cssmin grunt-contrib-handlebars grunt-contrib-imagemin grunt-contrib-sass grunt-contrib-uglify grunt-contrib-watch grunt-gh-pages grunt-template grunt-usemin
###

# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt, options) ->
  pkg = grunt.file.readJSON('package.json')

  options = _.defaults options, DEFAULT_OPTIONS

  # welcome message and log options
  grunt.log.subhead 'Backstrap!'
  for key, value of DEFAULT_OPTIONS
    grunt.log.writeln "  #{key}#{"          ".slice(key.length)}:", options[key]

  # load all grunt tasks and time execution
  require('load-grunt-tasks') grunt
  require('time-grunt') grunt

  # prefix each entry in given type option with dir path
  mkpath = (dir, type) ->
    "#{options.paths[dir]}/#{src}" for src in options[type]

  ###### PLUGIN CONFIGURATIONS ######
  grunt.initConfig
    options: options

    pkg: pkg

    # grunt-contrib-watch
    watch:
      browserify:
        files: mkpath 'app', 'scripts'
        tasks: ['browserify']
      handlebars:
        files: mkpath 'app', 'templates'
        tasks: ['handlebars']
      sass:
        files: mkpath 'app', 'styles'
        tasks: ['sass'] #, 'autoprefixer']
      livereload:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: ['dist/**/*.{js,css,html,json,png}']

    clean:
      dist: ['dist']

    # grunt-browserify
    browserify:
      options:
        transform: ['coffeeify']
      dev:
        options:
          bundleOptions:
            debug: true # coffee sourcemaps!!!
        files:
          'dist/scripts/index.js': ['app/scripts/index.coffee']
      dist:
        files:
          'dist/scripts/index.js': ['app/scripts/index.coffee']

    # grunt-contrib-sass
    sass:
      dist:
        options:
          style: 'compact'
        files:
          'dist/styles/index.css': mkpath 'app', 'styles'

    # grunt-contrib-handlebars
    handlebars:
      dist:
        files:
          'dist/scripts/templates.js': mkpath 'app', 'templates'
        options:
          namespace: 'Templates'
          processName: (filename) ->
            filename.match(/templates\/(.+)\.h[bj]s$/)[1]

    # grunt-contrib-copy
    copy:
      dist:
        files: [
          {expand: true, cwd: 'app', src: options.assets, dest: 'dist'},
        ]

    # grunt-contrib-imagemin
    imagemin:
      dist:
        expand: true
        cwd: 'app'
        src: ['images/*.png']
        dest: 'dist'

    # grunt-usemin
    useminPrepare:
      html: 'app/index.html'

    # grunt-usemin
    usemin:
      options:
        dirs: ['dist']
      html: ['dist/{,*/}*.html']

    # grunt-contrib-connect
    connect:
      options:
        port: 9000
        livereload: 35729
        # Change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'
      livereload:
        options:
          open: true
          base: ['app', 'dist']
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
          open: 'https://giladgray.github.io/<%= pkg.name %>'

    # grunt-gh-pages
    'gh-pages':
      options:
        base: 'dist'
      src: ['**']

  ######### TASK DEFINITIONS #########

  # compile assets for development
  grunt.registerTask 'build', 'compile assets for development', (target = 'dist') ->
    grunt.task.run [
      'clean'
      'sass'
      'handlebars'
      "browserify:#{target}"
      'copy'
    ]

  # build, dev server, watch
  grunt.registerTask 'dev', [
    'build:dev'
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
    'build:dist',
    'copy',
    'minify',
    'connect:dist:keepalive'
  ]

  # publish dist/ directory to github and open page
  grunt.registerTask 'deploy', [
    'gh-pages'
    'connect:github'
  ]

  grunt.registerTask 'default', ['dev']
