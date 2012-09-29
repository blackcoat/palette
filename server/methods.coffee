# Set up an N x N board
BOARD_SIZE  = 8
BOARD_RANGE = [0..(BOARD_SIZE-1)]

STARTING_COLORS = [
  '#FF0000', '#00FF00', '#0000FF',
  '#FFFF00', '#FF00FF', '#00FFFF',
  '#7FFF00', '#007FFF', '#FF007F',
  '#FF7F00', '#00FF7F', '#7F00FF',
]

Meteor.methods
  # For testing purposes, automatically starts
  # a new game and initializes the board
  init_game: ->
    console.log '[server] Meteor.methods#init_game'
    game_id = Games.insert name:'Test game'
    colors = Meteor.call 'randomize_colors'
    Squares.insert new Square {color:colors[r][c], row:r, col:c, game_id:game_id} for c in BOARD_RANGE for r in BOARD_RANGE
    Meteor.call 'init_pieces', game_id
    game_id
  
  # Generates the colors to be applied to an N x N board when 
  # initializing a new game. The color arrangement should exhibit
  # rotational symmetry, and includes white/black squares where
  # each player's pieces will be set up.
  #
  # Since we desire a symmetric color arrangement should, we need 
  # to generate *all* colors for the board in a single step instead 
  # of applying colors randomly as each Square is created.
  randomize_colors: (seed) ->
    # Init the N x N map where our colors will be saved
    square_colors = new Array BOARD_SIZE
    for i in BOARD_RANGE
      square_colors[i] = new Array BOARD_SIZE
    
    # Paint our starting squares near the center of the board
    square_colors[BOARD_SIZE/2][BOARD_SIZE/2] = '#FFFFFF'
    square_colors[BOARD_SIZE/2 - 1][BOARD_SIZE/2 - 1] = '#FFFFFF'
    square_colors[BOARD_SIZE/2 - 1][BOARD_SIZE/2] = '#000000'
    square_colors[BOARD_SIZE/2][BOARD_SIZE/2 - 1] = '#000000'
    
    # Place our colors symmetrically about the board
    # Remember that we only have to loop through half of the squares
    # on the board, while placing the same color at the corresponding
    # opposite location.
    #
    # Since we already filled in the starting squares, be sure not to
    # paint over anything that already has a color
    for r in BOARD_RANGE
      for c in [0..(BOARD_SIZE - 1 - r)]
        unless square_colors[r][c]
          color = STARTING_COLORS[Math.floor Math.random() * STARTING_COLORS.length]
          square_colors[r][c] = color
          square_colors[BOARD_SIZE - 1 - r][BOARD_SIZE - 1 - c] = color
    square_colors
  
  init_pieces: (game_id) ->
    p1_rook = new Piece 'rook', 'white'
    Squares.update {game_id: game_id, row: 3, col: 3}, {$set: {occupant: p1_rook}}
    
    p1_bishop = new Piece 'bishop', 'white'
    Squares.update {game_id: game_id, row: 4, col: 4}, {$set: {occupant: p1_bishop}}
    
    p2_rook = new Piece 'rook', 'black'
    Squares.update {game_id: game_id, row: 3, col: 4}, {$set: {occupant: p2_rook}}
    
    p2_bishop = new Piece 'bishop', 'black'
    Squares.update {game_id: game_id, row: 4, col: 3}, {$set: {occupant: p2_bishop}}
