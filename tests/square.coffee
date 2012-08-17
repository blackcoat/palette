##
# Spec-style unit tests for Squares on the Board during a game of Palette

# Need to use Coffeescript's destructuring to reference
# the object bound in the returned scope
# http://coffeescript.org/#destructuring
{Square} = require '../shared/square'

describe 'Square', ->
  describe '#select', ->
    it 'marks the Square as "selected"', ->
      s = new Square { selected: false }
      s.select
      s.should.be.true
      
  describe '#is_active', ->
  describe '#occupied_by', ->
    it 'returns a single Piece situated in the Square'
