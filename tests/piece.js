/**
 * Spec-style unit tests for Pieces moved by Players in Palette
 */

require ( 'should' )

describe( 'Piece', function() {
	describe( '#move', function() {
		it ( 'can only be moved by the Player who owns the piece' )
		it ( 'can only move diagonally with the diagnoal movement pattern' )
		it ( 'can only move horizontally/vertically with the orthogonal movement pattern' )
		it ( 'cannot move into a Square "owned" by the opposing Player' )
		it ( 'cannot move into a Square occupied by another Piece')
		it ( 'cannot move off of the Board')
	})
})
