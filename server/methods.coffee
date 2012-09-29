# Set up an N x N board
BOARD_SIZE = 8

Meteor.methods
  # For testing purposes, automatically starts
  # a new game and initializes the board
  init_game: ->
    console.log '[server] Meteor.methods#init_game'
    game_id = Games.insert name:'Test game'
    size = [0..(BOARD_SIZE-1)]
    colors = Meteor.call 'randomize_colors'
    Squares.insert new Square {color:colors[r][c], row:r, col:c, game_id:game_id} for c in size for r in size
    Meteor.call 'init_pieces', game_id
    game_id
  
  randomize_colors: (seed) ->
    # for now, just return a fixed patten of colors until
    # we implement a color-randomization algorithm
    [ ['#00FFFF','#FF00FF','#FFFF00','#00FF00','#00FF00','#FFFF00','#FF00FF','#00FFFF'],
      ['#FF00FF','#FF0000','#FF00FF','#FFFF00','#FFFF00','#FF00FF','#FF0000','#FF00FF'],
      ['#00FFFF','#FF00FF','#7F00FF','#00FFFF','#0000FF','#00FFFF','#FF00FF','#7F00FF'],
      ['#00FF7F','#00FF7F','#0000FF','#FFFFFF','#000000','#007FFF','#007FFF','#00FFFF'],
      ['#00FFFF','#007FFF','#007FFF','#000000','#FFFFFF','#0000FF','#00FF7F','#00FF7F'],
      ['#7FFF00','#FF00FF','#00FFFF','#0000FF','#00FFFF','#7F00FF','#FF00FF','#00FFFF'],
      ['#FF00FF','#FF0000','#FF00FF','#FFFF00','#FFFF00','#FF00FF','#FF0000','#FF00FF'],
      ['#00FFFF','#FF00FF','#FFFF00','#00FF00','#00FF00','#FFFF00','#FF00FF','#00FFFF'],
    ]
  
  init_pieces: (game_id) ->
    p1_rook = new Piece 'rook', 'white'
    Squares.update {game_id: game_id, row: 3, col: 3}, {$set: {occupant: p1_rook}}
    
    p1_bishop = new Piece 'bishop', 'white'
    Squares.update {game_id: game_id, row: 4, col: 4}, {$set: {occupant: p1_bishop}}
    
    p2_rook = new Piece 'rook', 'black'
    Squares.update {game_id: game_id, row: 3, col: 4}, {$set: {occupant: p2_rook}}
    
    p2_bishop = new Piece 'bishop', 'black'
    Squares.update {game_id: game_id, row: 4, col: 3}, {$set: {occupant: p2_bishop}}
