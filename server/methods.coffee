Meteor.methods
  # For testing purposes, automatically starts
  # a new game and initializes the board
  init_game: ->
    console.log '[server] Meteor.methods#init_game'
    game_id = Games.insert name:'Test game'
    size = [0..7]
    colors = Meteor.call 'randomize_colors'
    Squares.insert new Square {color:colors[r][c], row:r, col:c, game_id:game_id} for c in size for r in size
    Meteor.call 'init_pieces', game_id
    game_id
  
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
  
  init_pieces: (game_id) ->
    p1_rook = new Piece 'rook'
    Squares.update {game_id: game_id, row: 3, col: 3}, {$set: {occupant: p1_rook}}
    
    p1_bishop = new Piece 'bishop'
#    @squares[4][4].occupant = p1_bishop
    
    p2_rook = new Piece 'rook'
#    @squares[3][4].occupant = p2_rook
    
    p2_bishop = new Piece 'bishop'
#    @squares[4][3].occupant = p2_bishop
