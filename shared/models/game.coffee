##
# Stores all information about a 2-player game session

class Game
  constructor: (params={}) ->
    @board = new Board