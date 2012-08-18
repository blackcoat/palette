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
    
  
  randomize_colors: (seed) ->
    # for now, just return a fixed patten of colors until
    # we implement a color-randomization algorithm
    [ ['#00FFFF','#FF00FF','#FFFF00','#00FF00','#00FF00','#FFFF00','#FF00FF','#00FFFF'],
      ['#FF00FF','#FF0000','#FF00FF','#FFFF00','#FFFF00','#FF00FF','#FF0000','#FF00FF'],
      ['#00FFFF','#FF00FF','#00FFFF','#00FFFF','#0000FF','#00FFFF','#FF00FF','#00FFFF'],
      ['#00FFFF','#00FFFF','#0000FF','#FFFFFF','#000000','#00FFFF','#00FFFF','#00FFFF'],
      ['#00FFFF','#00FFFF','#00FFFF','#000000','#FFFFFF','#0000FF','#00FFFF','#00FFFF'],
      ['#00FFFF','#FF00FF','#00FFFF','#0000FF','#00FFFF','#00FFFF','#FF00FF','#00FFFF'],
      ['#FF00FF','#FF0000','#FF00FF','#FFFF00','#FFFF00','#FF00FF','#FF0000','#FF00FF'],
      ['#00FFFF','#FF00FF','#FFFF00','#00FF00','#00FF00','#FFFF00','#FF00FF','#00FFFF'],
    ]
