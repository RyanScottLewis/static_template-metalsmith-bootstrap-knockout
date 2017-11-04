# Requires
execSync = require('child_process').execSync

# Default tasks
buildTask = 'development'
cleanTask = 'build'

# Helpers
setupDependencies = -> console.log execSync('npm install').toString()
buildDevelopment  = -> console.log execSync('ENV=development coffee lib/build.coffee').toString()
buildProduction   = -> console.log execSync('coffee lib/build.coffee').toString()
buildDefault      = -> switch buildTask
  when 'development' then buildDevelopment()
  when 'production'  then buildProduction()
cleanBuild        = -> console.log execSync('rm -rf build').toString()
cleanDependencies = -> console.log execSync('rm -rf node_modules').toString()
cleanAll          = -> cleanBuild() && cleanDependencies()
cleanDefault      = -> switch cleanTask
  when 'build'        then cleanBuild()
  when 'dependencies' then cleanDependencies()
  when 'all'          then cleanAll()

# Tasks

task 'setup',              'Setup dependencies', setupDependencies
task 'build:development',  'Build the application for the development environment', buildDevelopment
task 'build:production',   'Build the application for the production environment', buildProduction
task 'build',              'Build default (build:' + buildTask + ')', buildDefault
task 'clean:build',        'Clean build files', cleanBuild
task 'clean:dependencies', 'Clean dependencies', cleanDependencies
task 'clean:all',          'Clean all files', cleanAll
task 'clean',              'Clean default (clean:' + cleanTask + ')', cleanDefault
