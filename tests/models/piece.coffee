##
# Spec-style unit tests for Pieces moved by Players in Palette

# Need to use Coffeescript's destructuring to reference
# the object bound in the returned scope
# http://coffeescript.org/#destructuring
{Piece} = require '../../shared/models/piece'

describe 'Piece', ->
  describe '#new', ->

    describe '"white" pieces', ->
      white_piece = new Piece 'rook', 'white'
      it 'uses "additive" color mixing', ->
        white_piece.mode.should.eql 'additive'

    describe '"black" pieces', ->
      black_piece = new Piece 'rook', 'black'
      it 'uses "subtractive" color mixing', ->
        black_piece.mode.should.eql 'subtractive'

	describe '#move', ->
		it 'can only be moved by the Player who owns the piece'
		it 'can only move diagonally with the diagonal movement pattern'
		it 'can only move horizontally/vertically with the orthogonal movement pattern'
		it 'cannot move into a Square "owned" by the opposing Player'
		it 'cannot move into a Square occupied by another Piece'
		it 'cannot move off of the Board'
