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


# Export this code to our global namespace
# This is needed when running Mocha
#
# Note that a simple `root = exports ? window`
# will cause Meteor to crash. We need this
# long-hand format for the conditional.
root = exports if exports?
root?= window if window?
root.Square = Square