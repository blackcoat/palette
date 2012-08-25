##
# The game Board on which Palette is played

class Board
  constructor: (params) ->
    # build our N x N game board. Each square
    # on the board will have a predetermined
    # color based on a symmetric pattern
    size = [0..7]
    colors = @randomize_colors()
    @squares = ( new Square color: colors[r][c] for c in size for r in size )
    
  
