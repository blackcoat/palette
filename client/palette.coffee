Template.board.id = ->
  Session.get 'game_id'

Template.board.squares = ->
  squares = Squares.find {game_id: Session.get 'game_id'}, {sort: ['row', 'col']}
  squares.map (n) -> n

Template.square.occupant = ->
  # For the moment, use the appropriate
  # Unicode chess symbol for our pieces.
  # We'll start with the white pieces for now.
  # http://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
  symbol = 
    bishop:
      white: '♗'
      black: '♝'
    rook: 
      white: '♖'
      black: '♜'
  
  if @.occupant?
    symbol[@.occupant.type][@.occupant.owner]

##
# Choose a piece on the board, then choose the
# destination for the piece.
# 
# We only interact with the board when we're trying
# to move a Piece (aka an "occupant" of a square)
# from one place on the board to another. This takes
# two clicks:
# 
# * choose the piece to move
# * choose the destination where the piece will reside
# 
# After selecting a piece, we will save a reference to
# the square occupied by the piece in Session['selected_square'].
# Once the piece if moved to a destination, 'selected_square'
# will be cleared.
Template.square.events 'click' : (event) ->
  if not (Session.get 'selected_square')?
    if @.occupant?
      Session.set 'selected_square', @
      $('#' + @._id).addClass('selected')
      Meteor.call 'show_destinations', @
  else
    origin = Session.get 'selected_square'
    if not @.occupant?
      piece_to_move = origin.occupant
      Squares.update origin._id, {$set: {occupant: null}}
      Squares.update @._id, {$set: {occupant: piece_to_move}}
    $('#' + origin._id).removeClass('selected')
    Session.set 'selected_square', null

Template.games.games = ->
  games = Games.find()

Template.games.events 'click #clear-all-games' : (event) ->
    Games.remove {}
    Squares.remove {}


# While prototyping, start up a new *local* game 
# every time the application loads
Meteor.startup ->
  console.log '**Starting Palette @ ' + new Date() + '**'
  unless Session.get('game_id')?
    Meteor.call 'init_game', (error, game_id) ->
      Session.set 'game_id', game_id

Meteor.methods
  show_destinations: (origin) ->
    if origin.occupant.type is 'rook'
      destinations = $('.square[data-row=' + origin.row + '], .square[data-col=' + origin.col + ']')
    else 
      # Keep a list of which directions we go in away from the origin
      # If we encounter a Square of the opposite color, stop moving in that direction
      # Similarly, don't bother looking in that direction anymore if we're going
      # beyond the boundaries of the board
      directions = 
        nw: {row:-1, col:-1}
        ne: {row:-1, col: 1}
        se: {row: 1, col: 1}
        sw: {row: 1, col:-1}
      size = [0..7]
      selectors = [].concat.apply([], ('.square[data-row=' + (origin.row + offset * vector.row) + '][data-col=' + (origin.col + offset * vector.col) + ']' for offset in size for direction,vector of directions))
      destinations = $(selectors.join ',')
    destinations.css({'z-index': 100})
    $('#board-overlay').fadeIn('fast')
