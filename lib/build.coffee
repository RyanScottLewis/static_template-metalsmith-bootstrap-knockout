path         = require('path')
metalsmith   = require('metalsmith')
copy         = require('metalsmith-copy')
coffee       = require('metalsmith-coffee')
sass         = require('metalsmith-sass')
inPlace      = require('metalsmith-in-place')

# TODO: Install jquery, bootstrap, popper, knockout to separate node modules, copy out dist files then
#       remove all other files so it doesnt take forever to build

renameFileMin = (file) ->

  path.join(path.dirname(file), path.basename(file, '.min.js') + '.js')

app = metalsmith(__dirname)
  .source '..'

  # Includes (Negated ignores)
  # .ignore "!**/{#{[
  .ignore "!**/{#{[
    'app/**',
    # 'node_modules/**/{dist,output}/{jquery.min.js,popper.min.js,**/bootstrap.min.{js,css},knockout-latest.js}'
    'node_modules/bootstrap/dist/css/bootstrap.min.css',
    'node_modules/bootstrap/dist/js/bootstrap.min.js',
    'node_modules/jquery/dist/jquery.min.js',
    'node_modules/knockout/build/knockout-latest.js',
    'node_modules/popper.js/dist/popper.min.js',
  ].join(',')}}"

  .destination '../build'

  .use(inPlace())
  .use(sass())
  # # TODO: CSS compressor
  .use(coffee())


# path.parse('/home/user/dir/file.txt');
# // Returns:
# // { root: '/',
# //   dir: '/home/user/dir',
# //   base: 'file.txt',
# //   ext: '.txt',
# //   name: 'file' }


  .use copy(pattern: '**/knockout-latest.js', move: true, transform: (file) -> 'knockout.js')
  .use copy(pattern: '**/*.min.*',            move: true, transform: renameFileMin
  # .use copy(pattern: '**/*.min.js',           move: true, transform: (file) -> file.replace('.min.js', '.js'))

  .use copy(pattern: '**/*.html', directory: '.',    move: true)
  .use copy(pattern: '**/*.css' , directory: 'css',  move: true)
  .use copy(pattern: '**/*.js',   directory: 'js',   move: true)

  # .use copy(pattern: '**/*.min.*',            move: true, transform: (file) -> 'knockout.js')

app.build (err, files) -> throw err if (err)
