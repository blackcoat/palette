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

# Export our class to Node.js when running
# other modules, e.g. our Mocha tests
exports.Game = Game unless Meteor?