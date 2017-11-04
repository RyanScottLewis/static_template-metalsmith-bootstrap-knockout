path         = require('path')
metalsmith   = require('metalsmith')
copy         = require('metalsmith-copy')
coffee       = require('metalsmith-coffee')
sass         = require('metalsmith-sass')
inPlace      = require('metalsmith-in-place')

app = metalsmith(__dirname)
  .source '..'

  # Includes (Negated ignores)
  .ignore "!**/{#{[
    'app/**',
    'node_modules/bootstrap/dist/css/bootstrap.min.css',
    'node_modules/bootstrap/dist/js/bootstrap.min.js',
    'node_modules/jquery/dist/jquery.min.js',
    'node_modules/knockout/build/knockout-latest.js',
    'node_modules/popper.js/dist/umd/popper.min.js', # Breaks without "umd" version
  ].join(',')}}"

  .destination '../build'

  .use(inPlace())
  .use(sass())
  # # TODO: CSS compressor
  .use(coffee())

  .use copy(pattern: '**/knockout-latest.js', move: true, transform: (file) -> 'knockout.js')
  .use copy(pattern: '**/*.min.*',            move: true, transform: (file) -> file.replace(/\.min(\..+)/, '$1'))

  .use copy(pattern: '**/*.html', directory: '.',    move: true)
  .use copy(pattern: '**/*.css' , directory: 'css',  move: true)
  .use copy(pattern: '**/*.js',   directory: 'js',   move: true)

app.build (err, files) -> throw err if (err)
