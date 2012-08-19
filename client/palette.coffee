Template.hello.greeting = ->
  "Welcome to palette, a two-player color-matching game."

Template.board.squares = ->
  game = Session.get 'game'
  jQuery.map game.board.squares, (n) -> n

Template.square.events = 'click' : (event) ->
  console.log "You clicked on:"
  console.log this

# While prototyping, start up a new *local* game 
# every time the application loads
Meteor.startup ->
  console.log 'starting Palette'
  params =
    players: [{name: 'Player 1'}, {name: 'Player 2'}]
  Session.set 'game', new Game params