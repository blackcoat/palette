# Loading node.js core modules for handling files and file paths
# http://nodejs.org/api/fs.html#fs_file_system
# http://nodejs.org/api/path.html#path_path
fs = require 'fs'
path = require 'path'

# Find the root of our Meteor app
# Question: why doesn't `__dirname` work here?
root = path.join path.dirname(module.filename), '..'

# Locate our Meteor bundle
bundle = path.join root, '.meteor', 'local', 'build'

# Use the version of Underscore.js bundled with our app.
# Right now, this assumes that the 'underscore' package
# has been added + bundled to your project. If you haven't
# done this already, run the following command:
#
#     meteor add underscore && meteor
#
_ = require path.join bundle, 'app', 'packages', 'underscore', 'underscore.js'

# Synchronously load our model definitions prior to running
# our tests. Assume the following:
#
# * Filenames for our tests match those of the model being tested
# * Each model is exported
# * Tests are located in  `/tests/models`
# * Models are located in `/shared/models`
#
_.extend(global, require path.join(root, 'shared', 'models', model)) for model in fs.readdirSync path.join root, 'tests', 'models'
