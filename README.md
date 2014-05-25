gruntfile
=========

A great starter Gruntfile with a complete development workflow.

## Installation
Add this `Gruntfile.coffee` to your projects, either by downloading it or copy-pasting the text. Run the following commands in your terminal to install and save Grunt and the packages used in this Gruntfile. Then use the workflow described below for kickass frontend web development!

```bash
# globally install Grunt and CoffeeScript
$ npm install -g grunt-cli coffee-script

# basic grunt tools
$ npm install --save-dev browserify coffeeify grunt load-grunt-tasks time-grunt`

# individual grunt plugins
$ npm install --save-dev grunt-browserify grunt-contrib-clean grunt-contrib-concat grunt-contrib-connect grunt-contrib-copy grunt-contrib-cssmin grunt-contrib-handlebars grunt-contrib-imagemin grunt-contrib-sass grunt-contrib-uglify grunt-contrib-watch grunt-gh-pages grunt-template grunt-usemin`
```

## Workflow

### Grunt Targets
* **`grunt build`**: compile sources (Coffee, Sass, templates) from `app/` to `dist/`
* **`grunt dev` &rArr; `grunt`**: compile source and launch a development server that watches changes and reloads the browser
* **`grunt minify`**: optimize and obfuscate compiled source files for production (run `grunt build` first)
* **`grunt dist`**: build and minify source code in `dist/`, copy production assets, and launch a static production preview server
* **`grunt deploy`**: upload production source to your project's GitHub Page (`http://<username>.github.io/<project>`)

### Common Workflow
Generally, you'll run `grunt dev` (or simply `grunt` for convenience) while you develop. This command launches the development server which watches for changes to source files and recompiles and reloads intelligently.

When you're ready to deploy a new version, you'll run `grunt dist` to test the compiled code. This command launches a preview server so you can interact with the compiled code. It does not watch for changes so any fixes will likely require some more `grunt dev`. Once you are satisfied with your updates, you can run `grunt deploy` to upload the contents of the `dist/` directory to a GitHub Page.

## Technologies
This Grunt workflow comes with an opinionated set of web technologies.

**[CoffeeScript](http://coffeescript.org)** is "a little language that compiles into JavaScript." It merges the power, flexibility, and portability of JavaScript with the pure joy of developer-friendly scripting languages like Ruby and Python. It augments basic JavaScript syntax with a whitespace-sensitive syntax, Python-style comprehensions, simpler English keywords, and a useful `class` structure with basic inheritance. You're going to love it.

**[Browserify](http://browserify.org/)** lets you `require('modules')` in the browser just like in Node, and bundles all your dependencies effortlessly. This workflow uses Browserify to perform the CoffeeScript compilation and to bundle all your source files for the client.

**[Sass](http://sass-lang.com)** is "the most mature, stable, and powerful professional grade CSS extension language in the world." It's a CSS pre-processor (equivalent to LESS or Stylus) with a host of powerful features and an active developer community.

**[Handlebars](http://handlebarsjs.com/)** is "minimal templating on steroids." It's an incredibly simple languge for writing fast, reusable HTML templates. All your template files will be pre-compiled by Grunt and served to the browser in one simple file.

**[UglifyJS](https://github.com/mishoo/UglifyJS2)** is a "JavaScript parser/mangler/compressor/beautifier toolkit." With the [grunt-contrib-uglify](https://github.com/gruntjs/grunt-contrib-uglify) plugin, it's basically a production build tool in a box, performing everything from concatenation to compression to obfuscation for both our JavaScript and our CSS. This ensures that your final compiled project is as small and fast as possible.
