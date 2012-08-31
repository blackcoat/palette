Template.board.id = ->
  Session.get 'game_id'

Template.board.squares = ->
  squares = Squares.find()
  squares.map (n) -> n

Template.square.events = 'click' : (event) ->
  console.log "You clicked on:"
  console.log @
  Squares.update @._id, {$set: {selected: true}}

Template.games.games = ->
  games = Games.find()

Template.games.events = 
  'click #clear-all-games' : (event) ->
    Games.remove {}
    Squares.remove {}


# While prototyping, start up a new *local* game 
# every time the application loads
Meteor.startup ->
  console.log 'starting Palette'
  Meteor.call 'init_game'