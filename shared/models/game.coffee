##
# Stores all information about a 2-player game session

class Game
  constructor: (params={}) ->
    @squares = ({} for c in Board.range for r in Board.range)
    @players = params.players or []
  
  start: ->
    if @players.length is 2
      init_pieces()
      true
    else
      false

# Export our class to Node.js when running
# other modules, e.g. our Mocha tests
exports.Game = Game unless Meteor?