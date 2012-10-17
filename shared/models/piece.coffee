##
# The Pieces on the Board moved by each respective Player

class Piece
  constructor: (@type, @owner) ->
    # String. The "type" of Piece dictates the movement
    # pattern used by the Piece.
    # 
    # Only acceptable values are:
    # * 'rook'
    # * 'bishop'
    
    
    # Player object. A reference to the Player who owns
    # this Piece. The owner is the only Player permitted
    # to move the Piece
    
    
    # Pair of integers representing the <row, col>
    # coordinates on the Board occupied by the Piece
    @location = 
      row: null
      col: null
    
    # The color-mixing mode used by the Piece. This setting
    # determines how our colors will be combined.
    # 
    # When moving through a white square, the Piece starts using
    # 'additive' color mixing. When moving over a black square, 
    # the Piece switches to 'subtractive' color mixing.
    @mode = if @owner is 'white' then 'additive' else 'subtractive'


# Export our class to Node.js when running
# other modules, e.g. our Mocha tests
exports.Piece = Piece unless Meteor?