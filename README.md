gruntfile
=========

A great starter Gruntfile with a complete development workflow

Usage
=====
Add this `Gruntfile.coffee` to your projects. Run the following commands in your terminal to install and save Grunt and the packages used in this Gruntfile:

```bash
# globally install Grunt and CoffeeScript
$ npm install -g grunt-cli coffee-script

# basic grunt tools
$ npm install --save-dev browserify coffeeify grunt load-grunt-tasks time-grunt`

# individual grunt plugins
$ npm install --save-dev grunt-browserify grunt-contrib-clean grunt-contrib-concat grunt-contrib-connect grunt-contrib-copy grunt-contrib-cssmin grunt-contrib-handlebars grunt-contrib-imagemin grunt-contrib-sass grunt-contrib-uglify grunt-contrib-watch grunt-gh-pages grunt-template grunt-usemin`
```

Workflow
========
### Grunt Targets
* **`grunt build`**: compile sources (Coffee, Sass, templates) from `app/` to `dist/`
* **`grunt dev` &rArr; `grunt`**: compile source and launch a development server that watches changes and reloads the browser
* **`grunt minify`**: optimize and obfuscate compiled source files for production (run `grunt build` first)
* **`grunt dist`**: build and minify source code in `dist/`, copy production assets, and launch a static production preview server
* **`grunt deploy`**: upload production source to the [GitHub Page](http://giladgray.github.io/mmindd-mmvp/)

### Common Workflow
Generally, you'll run `grunt dev` (or simply `grunt` for convenience) while you develop. This command launches the development server which watches for changes to source files and recompiles and reloads intelligently.

When you're ready to deploy a new version, you'll run `grunt dist` to test the compiled code. This command launches a preview server so you can interact with the compiled code. It does not watch for changes so any fixes will likely require some more `grunt dev`. Once you are satisfied with your updates, you can run `grunt deploy` to upload the contents of the `dist/` directory to a GitHub Page.
