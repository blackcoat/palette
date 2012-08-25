##
# One of the Squares comprising the game's Board

class Square
  constructor: (params = {}) -> 
    # String. And RGB color in hexidecimal format, with preceeding '#'
    @color = params.color or '#888888'
    
    # Piece object. A reference to the Piece occupying the Square.
    # A square may only be occupied by one Piece at a time.
    @occupant = params.occupant or null
    
    # Boolean. Indicates whether or not the Player taking a turn has
    # selected a Piece to move. Unoccupied Squares cannot be selected.
    @selected = params.selected or false
    
    # Integer. The row of the game board where the Square is located
    @row = params.row ? -1
    
    # Integer. The column of the game board where the Square is located
    @col = params.col ? -1
  
  select: ->
    @selected = true


# Export our class to Node.js when running
# other modules, e.g. our Mocha tests
exports.Square = Square unless Meteor?