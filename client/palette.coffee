Template.board.id = ->
  Session.get 'game_id'

Template.board.squares = ->
  squares = Squares.find {game_id: Session.get 'game_id'}, {sort: ['row', 'col']}
  squares.map (n) -> n

Template.board.events 'click #board-overlay' : (event) ->
  UI.clear_selection()

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
      show_destinations @
  else
    origin = Session.get 'selected_square'
    if not @.occupant?
      piece_to_move = origin.occupant
      Squares.update origin._id, {$set: {occupant: null}}
      Squares.update @._id, {$set: {occupant: piece_to_move}}
      update_colors origin, @
    UI.clear_selection()

Template.games.games = ->
  games = Games.find()

Template.games.events 'click #clear-all-games' : (event) ->
    Games.remove {}
    Squares.remove {}


##
# User Interface Behaviors
# 
# Gameplay animations and UI behaviors belong to more than
# just one template. For now, we're going to namespace all
# such items in the UI object
UI = {}

UI.clear_selection = ->
  $('.selected').removeClass('selected')
  $('#board-overlay').fadeOut('fast')
  $('.square').css('z-index', 1)
  Session.set 'selected_square', null


# While prototyping, start up a new *local* game 
# every time the application loads
Meteor.startup ->
  console.log '**Starting Palette @ ' + new Date() + '**'
  unless Session.get('game_id')?
    Meteor.call 'init_game', (error, game_id) ->
      Session.set 'game_id', game_id

show_destinations = (origin) ->
  # Keep a list of which directions we go in away from the origin
  # Each direction has a vector that we will scale to track
  # how far away we go from the origin of our move.
  if origin.occupant.type is 'rook'
    directions = 
      n: {row:-1, col: 0}
      s: {row: 1, col: 0}
      e: {row: 0, col: 1}
      w: {row: 0, col:-1}
  else 
    directions = 
      nw: {row:-1, col:-1}
      ne: {row:-1, col: 1}
      se: {row: 1, col: 1}
      sw: {row: 1, col:-1}
  
  # Search for how far we can move a piece in each direction.
  # Stop searching for destinations in a direction if...
  # * a Square is occupied by another Piece
  # * we encounter a Square of the opposite color
  # * we would be moving beyond the boundaries of the board
  
  player_colors = ['white', 'black']
  
  selectors = []
  for direction,vector of directions
    offset = 0
    square = origin
    while square? and (square is origin or not square.occupant?) and ($.xcolor.nearestname(square.color) not in player_colors or $.xcolor.nearestname(square.color) is origin.occupant.owner)
      selectors.push '.square[data-row=' + (origin.row + offset * vector.row) + '][data-col=' + (origin.col + offset * vector.col) + ']'
      offset += 1
      square = Squares.findOne {row: (origin.row + offset * vector.row), col: (origin.col + offset * vector.col), game_id: origin.game_id}
  destinations = $(selectors.join ',')
  destinations.css({'z-index': 100})
  $('#board-overlay').fadeIn('fast')
  

update_colors = (origin, destination) ->
  piece = origin.occupant
  # If you are playing white or black, you can't use your desired
  # end color as a new painting_color. Otherwise, the game would
  # be far too easy. "I'll add white to *everything*"
  player_colors = ['white', 'black']
  painting_color = origin.color unless $.xcolor.nearestname(origin.color) in player_colors
  
  # Determine how our colors will be combined.
  mode = if piece.owner is 'white' then 'additive' else 'subtractive'
  
  # Our `for` loop doesn't run diagonally... yet. For now, just run
  # the color-updating code when moving rooks.
  for r in [origin.row..destination.row]
    for c in [origin.col..destination.col] when r isnt origin.row or c isnt origin.col # don't paint our origin
      if piece.type is 'rook' or (piece.type is 'bishop' and Math.abs(origin.row - r) is Math.abs(origin.col - c))
        square = Squares.findOne {row: r, col: c, game_id: origin.game_id}
        if painting_color? and $.xcolor.nearestname(square.color) not in player_colors
          square.color = $.xcolor[mode](square.color, painting_color).toString()
          Squares.update square._id, {$set: {color: square.color}}
        else
          # Pick up a new painting color if we don't have one already,
          # but we can't use our desired outcome color (white/black) as
          # a painting color
          painting_color = square.color unless $.xcolor.nearestname(square.color) in player_colors