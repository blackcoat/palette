/**
 * One of the Squares comprising the game's Board
 */

var Square = (function (params) {
  // Default values for our public members
  var defaults = {
    /**
     * String. And RGB color in hexidecimal format, with preceeding '#'
     */
    color: '#888888',
    
    /**
     * Piece object. A reference to the Piece occupying the Square.
     * A square may only be occupied by one Piece at a time.
     */
    occupant: null,
    
    /**
     * Boolean. Indicates whether or not the Player taking a turn has
     * selected a Piece to move. Unoccupied Squares cannot be selected.
     */
    selected: false,
  }
  
  // Merge our passed parameters and defaults into the class
  var merged_params = jQuery.extend({}, defaults, params)
  for(key in merged_params) {
    this[key] = merged_params[key]
  }
})
