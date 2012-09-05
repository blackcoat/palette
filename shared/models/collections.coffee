##
# Small models shared between the Client and Server architecture

##
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

##
# The collection of every Player engaged in or searching for a game.
# 
# * Members include:
# * game_id - reference to an active Game in session
# * name - name of the player
#
Players = new Meteor.Collection 'players'

Squares = new Meteor.Collection 'squares'

##
# @todo add collections for:
# * all unfinished games in which the Player is involved
# * finished games played by the Player
# * friends
# 

Meteor.methods
  # For testing purposes, automatically starts
  # a new game and initializes the board
  init_game: ->
    game_id = Games.insert name:'Test game'
    size = [0..7]
    colors = Meteor.call 'randomize_colors'
    Squares.insert new Square {color:colors[r][c], row:r, col:c, game_id:game_id} for c in size for r in size
  
  randomize_colors: (seed) ->
    # for now, just return a fixed patten of colors until
    # we implement a color-randomization algorithm
    [ ['#00FFFF','#FF00FF','#FFFF00','#00FF00','#00FF00','#FFFF00','#FF00FF','#00FFFF'],
      ['#FF00FF','#FF0000','#FF00FF','#FFFF00','#FFFF00','#FF00FF','#FF0000','#FF00FF'],
      ['#00FFFF','#FF00FF','#00FFFF','#00FFFF','#0000FF','#00FFFF','#FF00FF','#00FFFF'],
      ['#00FFFF','#00FFFF','#0000FF','#FFFFFF','#000000','#00FFFF','#00FFFF','#00FFFF'],
      ['#00FFFF','#00FFFF','#00FFFF','#000000','#FFFFFF','#0000FF','#00FFFF','#00FFFF'],
      ['#00FFFF','#FF00FF','#00FFFF','#0000FF','#00FFFF','#00FFFF','#FF00FF','#00FFFF'],
      ['#FF00FF','#FF0000','#FF00FF','#FFFF00','#FFFF00','#FF00FF','#FF0000','#FF00FF'],
      ['#00FFFF','#FF00FF','#FFFF00','#00FF00','#00FF00','#FFFF00','#FF00FF','#00FFFF'],
    ]
  