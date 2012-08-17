# Small models shared between the Client and Server architecture

 
# The collection of every Game instance. Each Game includes the members:
# 
# * board - the game board (Array of colors?)
# * initial_board - the state of the board at the start of the game
# * moves - array of Move objects. Serves as the history of gameplay. Can be used to replay the game
# * players - array of Player objects
# * winner - reference to the winning player. Game is not over until there is a winner. (Should multiple winners indicate a stalemate/tie?)
# * created_at - 
#
Games = new Meteor.Collection 'games'


# The collection of every Player engaged in or searching for a game.
# 
# * Members include:
# * game_id - reference to an active Game in session
# * name - name of the player
#
Players = new Meteor.Collection 'players'