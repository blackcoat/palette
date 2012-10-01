##
# Stores all information about a 2-player game session

# Meteor automatically includes our dependencies, but we will need to
# do this manually when running our tests. Because we are technically
# including scopes, we have to require the Board here instead of in
# our Mocha test because the Board has to be within the Game's scope
{Board} = require './board' unless Meteor?

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