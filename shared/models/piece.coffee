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
