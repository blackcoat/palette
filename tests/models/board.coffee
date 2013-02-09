##
# Spec-style unit tests for Board generation utilities needed for Palette

# Need to use Coffeescript's destructuring to reference
# the object bound in the returned scope
# http://coffeescript.org/#destructuring
require '../mocha-helper.coffee'

describe 'Board', ->
  it 'is a class', ->
    Board.should.be.a 'function'

  describe '#generate', ->
    it 'returns an N x N board', ->
      board = Board.generate()
      board.should.be.an.instanceOf(Array).and.have.length(Board.size)
      for row in board
        row.should.be.an.instanceOf(Array).and.have.length(Board.size)

    it 'creates a specific board given a particular seed, e.g. 123', ->
      first_board = Board.generate seed: 123
      second_board = Board.generate seed: 123
      first_board.should.eql second_board

    it 'creates different boards for different seeds', ->
      first_board = Board.generate seed: 1
      second_board = Board.generate seed: 2
      first_board.should.not.eql second_board

    it 'distributes colors (almost) evenly across the board', ->
      # Generate a random board, and count the occurrences of
      # each color appearing on the board, ignoring starting spaces
      # (i.e. black or white). To ensure a reasonable distribution,
      # keep the difference between the highest and fewest occurrences
      # of a color within a reasonable threshold
      found_colors = {}
      ignored_colors = ['#000000', '#FFFFFF']
      board = Board.generate seed: 123
      for row in Board.range
        for col in Board.range
          color = board[row][col]
          # when we first encounter a color, `found_colors[color]` will
          # evaluate to `null`, and `1 + null` is NaN.
          found_colors[color] = 1 + found_colors[color] or 1 unless color in ignored_colors
      max = Math.max value, max or 0 for color, value of found_colors
      min = Math.min value, min or value for color, value of found_colors
      (max - min).should.be.within 0, 4

  describe '#_colors', ->
    it 'returns a list of colors', ->
      Board._colors().should.be.an.instanceOf(Array)

    it 'returns as many colors as the size of the board (e.g. 8)', ->
      Board._colors().should.have.length(Board.size)

