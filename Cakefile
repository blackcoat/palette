# Required to run commands in the shell
{spawn, exec} = require 'child_process'

# Set up default arguments for running our Mocha tests
mocha_args = [
  'tests',
  '--compilers', 'coffee:coffee-script',
  '--require', 'should',
  '--ui', 'bdd',
  '--colors',
]


task 'test', 'runs the Mocha test suite', ->
  args = mocha_args.concat ['--reporter', 'spec']...
  spawn 'mocha', args, stdio: 'inherit'

task 'test:watch', 'runs the Mocha test suite whenever a file on the project is changed', ->
  args = mocha_args.concat [
    '--reporter', 'min',
    '--watch'
  ]...
  spawn 'mocha', args, stdio: 'inherit'