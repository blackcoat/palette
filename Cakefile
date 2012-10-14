# Required to run commands in the shell
{spawn, exec} = require 'child_process'

task 'test', 'runs the Mocha test suite', ->
  args = [
    'tests',
    '--compilers', 'coffee:coffee-script',
    '--require', 'should',
    '--reporter', 'spec'
  ]
  child = spawn 'mocha', args, stdio: 'inherit'
