/**
 * 
 */

var Board = (function (params) {
	
	// Default values for our public members
	var defaults = {}	
	
	// The public Board object to be returned by `new Board()`
	var board = function (params) {
		// Merge our passed parameters and defaults into the Board
		var merged_params = jQuery.extend({}, defaults, params)
		for(key in merged_params) {
			this[key] = merged_params[key]
		}
		
		this.squares = init_squares()
	}
	
	// Public methods for all new Boards
	board.prototype = {
		testPrototype: function () { console.log('testing prototype inheritance') }
	}
	
	// Private method for coloring in the board
	var init_squares = function (seed) {
		// for now, just return a test set of squares
		return [
			['#00FFFF','#FF00FF','#FFFF00','#FFFF00','#FFFF00','#FFFF00','#FF00FF','#00FFFF'],
			['#FF00FF','#FF0000','#FF00FF','#FFFF00','#FFFF00','#FF00FF','#FF0000','#FF00FF'],
			['#00FFFF','#FF00FF','#00FFFF','#00FFFF','#0000FF','#00FFFF','#FF00FF','#00FFFF'],
			['#00FFFF','#00FFFF','#0000FF','#FFFFFF','#000000','#00FFFF','#00FFFF','#00FFFF'],
			['#00FFFF','#00FFFF','#00FFFF','#000000','#FFFFFF','#0000FF','#00FFFF','#00FFFF'],
			['#00FFFF','#FF00FF','#00FFFF','#0000FF','#00FFFF','#00FFFF','#FF00FF','#00FFFF'],
			['#FF00FF','#FF0000','#FF00FF','#FFFF00','#FFFF00','#FF00FF','#FF0000','#FF00FF'],
			['#00FFFF','#FF00FF','#FFFF00','#FFFF00','#FFFF00','#FFFF00','#FF00FF','#00FFFF'],
		]
	}
	
	return board
})();

