Meteor.methods
  # For testing purposes, automatically starts
  # a new game and initializes the board
  init_game: ->
    console.log '[server] Meteor.methods#init_game'
    game_id = Games.insert name:'Test game'
    colors = Board.generate()
    Squares.insert new Square {color:colors[r][c], row:r, col:c, game_id:game_id} for c in Board.range for r in Board.range
    Meteor.call 'init_pieces', game_id
    game_id
  
  init_pieces: (game_id) ->
    p1_rook = new Piece 'rook', 'white'
    Squares.update {game_id: game_id, row: 3, col: 3}, {$set: {occupant: p1_rook}}
    
    p1_bishop = new Piece 'bishop', 'white'
    Squares.update {game_id: game_id, row: 4, col: 4}, {$set: {occupant: p1_bishop}}
    
    p2_rook = new Piece 'rook', 'black'
    Squares.update {game_id: game_id, row: 3, col: 4}, {$set: {occupant: p2_rook}}
    
    p2_bishop = new Piece 'bishop', 'black'
    Squares.update {game_id: game_id, row: 4, col: 3}, {$set: {occupant: p2_bishop}}
