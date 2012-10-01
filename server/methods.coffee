Meteor.methods
  # For testing purposes, automatically starts
  # a new game and initializes the board
  init_game: ->
    console.log '[server] Meteor.methods#init_game'
    game_id = Games.insert name:'Test game'
    colors = Meteor.call 'randomize_colors'
    Squares.insert new Square {color:colors[r][c], row:r, col:c, game_id:game_id} for c in Board.range for r in Board.range
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
    square_colors = new Array Board.size
    for i in Board.range
      square_colors[i] = new Array Board.size
    
    # Paint our starting squares near the center of the board
    square_colors[Board.size/2][Board.size/2] = '#FFFFFF'
    square_colors[Board.size/2 - 1][Board.size/2 - 1] = '#FFFFFF'
    square_colors[Board.size/2 - 1][Board.size/2] = '#000000'
    square_colors[Board.size/2][Board.size/2 - 1] = '#000000'
    
    # Place our colors symmetrically about the board
    # Remember that we only have to loop through half of the squares
    # on the board, while placing the same color at the corresponding
    # opposite location.
    #
    # Since we already filled in the starting squares, be sure not to
    # paint over anything that already has a color
    for r in Board.range
      for c in [0..(Board.size - 1 - r)]
        unless square_colors[r][c]
          color = Board.colors[Math.floor Math.random() * Board.colors.length]
          square_colors[r][c] = color
          square_colors[Board.size - 1 - r][Board.size - 1 - c] = color
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
