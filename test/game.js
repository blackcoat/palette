/**
 * Spec-style unit tests for Pieces moved by Players in Palette
 *
 * Meteor 0.3.8 always tries to load the unit tests, and crashes
 * when doing so. To prevent that from happening, we will only
 * define the tests if Meteor is not running.
 */

if (typeof(Meteor) === 'undefined') {

require ( 'should' )

describe( 'Game', function() {
	describe( '#resolveTurn', function() {
		it ( 'color in "enclosed" squares for the enclosing Player if their opponent has no presence in the enclosed space' )
		it ( 'evaulate win conditions after all other resolution actions' )
		it ( 'declare a Player the "winner" if they own more than 1/2 of the Squares on the Board' )
	})
})

} // end check for Meteor
