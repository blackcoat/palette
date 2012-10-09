##
# Spec-style unit tests for Board generation utilities needed for Palette

# Need to use Coffeescript's destructuring to reference
# the object bound in the returned scope
# http://coffeescript.org/#destructuring
{Board} = require '../shared/models/board'

describe 'Board', ->
  it 'is a class', ->
    Board.should.be.a 'function'
  
  describe '#generate', ->
    it 'returns an N x N board', ->
      board = Board.generate()
      board.should.be.an.instanceOf(Array).and.have.length(Board.size)
      for row in board
        row.should.be.an.instanceOf(Array).and.have.length(Board.size)
        
    it 'creates a specific board given a particular seed, e.g. 123', ->
      first_board = Board.generate seed: 123
      second_board = Board.generate seed: 123
      first_board.should.eql second_board
    
    it 'creates different boards for different seeds', ->
      first_board = Board.generate seed: 1
      second_board = Board.generate seed: 2
      first_board.should.not.eql second_board
