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
    bishop: '♗'
    rook: '♖'
  
  if @.occupant?
    symbol[@.occupant.type]

Template.square.events 'click' : (event) ->
  console.log "You clicked on:"
  console.log @
  Squares.update @._id, {$set: {selected: true}}

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
