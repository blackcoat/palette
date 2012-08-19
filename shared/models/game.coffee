##
# Stores all information about a 2-player game session

class Game
  constructor: (params={}) ->
    @board = new Board
    @players = params.players or []


# Export our class to Node.js when running
# other modules, e.g. our Mocha tests
exports.Game = Game unless Meteor?