##
# Factory used for setting up an N x N board

class Board
  constructor: ->
  
  @size = 8
  @range = [0...@size]
  @colors = [
    '#FF0000', '#00FF00', '#0000FF',
    '#FFFF00', '#FF00FF', '#00FFFF',
    '#7FFF00', '#007FFF', '#FF007F',
    '#FF7F00', '#00FF7F', '#7F00FF',
  ]
  
  
  # Generates the colors to be applied to an N x N board when 
  # initializing a new game. The color arrangement should exhibit
  # rotational symmetry, and includes white/black squares where
  # each player's pieces will be set up.
  #
  # Since we desire a symmetric color arrangement should, we need 
  # to generate *all* colors for the board in a single step instead 
  # of applying colors randomly as each Square is created.
  unless Meteor?.isClient
    @generate = ( params = {} ) ->
      # Set up our default options
      seed = params.seed or (new Date()).getTime()
      
      # Seed our random number generator to produce deterministic results
      # http://davidbau.com/archives/2010/01/30/random_seeds_coded_hints_and_quintillions.html
      #
      # Meteor automatically loads the library *and* Meteor doesn't like
      # Node's `require` method, so only explicitly include it when necessary
      require '../../server/lib/seedrandom' unless Math.seedrandom?
      Math.seedrandom seed
      
      # Init the N x N map where our colors will be saved
      square_colors = new Array Board.size
      for i in Board.range
        square_colors[i] = new Array Board.size
    
      # Paint our starting squares near the center of the board
      square_colors[Board.size/2][Board.size/2] = '#FFFFFF'
      square_colors[Board.size/2 - 1][Board.size/2 - 1] = '#FFFFFF'
      square_colors[Board.size/2 - 1][Board.size/2] = '#000000'
      square_colors[Board.size/2][Board.size/2 - 1] = '#000000'
    
      # Place our colors symmetrically about the board
      # Remember that we only have to loop through half of the squares
      # on the board, while placing the same color at the corresponding
      # opposite location.
      #
      # Since we already filled in the starting squares, be sure not to
      # paint over anything that already has a color
      colors = @_colors()
      for r in Board.range
        for c in [0...(@size - r)]
          unless square_colors[r][c]
            color = colors[Math.floor Math.random() * colors.length]
            square_colors[r][c] = color
            square_colors[Board.size - 1 - r][Board.size - 1 - c] = color
      square_colors
    
    # Generates a subset of available colors for use on a Palette board
    @_colors = ->
      @colors[0...@size]

# Export our class to Node.js when running
# other modules, e.g. our Mocha tests
exports.Board = Board unless Meteor?