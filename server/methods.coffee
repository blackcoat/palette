Meteor.methods
  # For testing purposes, automatically starts
  # a new game and initializes the board
  init_game: ->
    console.log '[server] Meteor.methods#init_game'
    game_id = Games.insert name:'Test game'
    size = [0..7]
    colors = Meteor.call 'randomize_colors'
    Squares.insert new Square {color:colors[r][c], row:r, col:c, game_id:game_id} for c in size for r in size
    game_id
  
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
