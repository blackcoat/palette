Template.board.squares = ->
  squares = Squares.find()
  squares.map (n) -> n

Template.square.events = 'click' : (event) ->
  console.log "You clicked on:"
  console.log @
  Squares.update @._id, {$set: {selected: true}}

Template.games.games = ->
  games = Games.find()


# While prototyping, start up a new *local* game 
# every time the application loads
Meteor.startup ->
  console.log 'starting Palette'
  params =
    players: [{name: 'Player 1', color: 'white'}, {name: 'Player 2', color: 'black'}]
  Meteor.call 'init_game'