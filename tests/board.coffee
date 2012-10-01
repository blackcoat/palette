##
# Spec-style unit tests for Board generation utilities needed for Palette

# Need to use Coffeescript's destructuring to reference
# the object bound in the returned scope
# http://coffeescript.org/#destructuring
{Board} = require '../shared/models/board'

describe 'Board', ->
  it 'is a class', ->
    Board.should.be.a 'function'
  