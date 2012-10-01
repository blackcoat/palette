##
# Factory used for setting up an N x N board

class Board
  constructor: ->
  
  @size = 8
  @range = [0..(@size - 1)]
  @colors = [
    '#FF0000', '#00FF00', '#0000FF',
    '#FFFF00', '#FF00FF', '#00FFFF',
    '#7FFF00', '#007FFF', '#FF007F',
    '#FF7F00', '#00FF7F', '#7F00FF',
  ]
  

# Export our class to Node.js when running
# other modules, e.g. our Mocha tests
exports.Board = Board unless Meteor?