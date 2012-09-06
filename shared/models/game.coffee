##
# Stores all information about a 2-player game session

class Game
  constructor: (params={}) ->
    size = [0..7]
    @squares = ({} for c in size for r in size)
    @players = params.players or []
  
  start: ->
    if @players.length is 2
      init_pieces()
      true
    else
      false
      
  init_pieces: ->
    p1_rook = new Piece 'rook', @players[0]
    @squares[3][3].occupant = p1_rook
    
    p1_bishop = new Piece 'bishop', @players[0]
    @squares[4][4].occupant = p1_bishop
    
    p2_rook = new Piece 'rook', @players[1]
    @squares[3][4].occupant = p2_rook
    
    p2_bishop = new Piece 'bishop', @players[1]
    @squares[4][3].occupant = p2_bishop


# Export our class to Node.js when running
# other modules, e.g. our Mocha tests
exports.Game = Game unless Meteor?