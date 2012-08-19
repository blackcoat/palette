##
# Spec-style unit tests for Pieces moved by Players in Palette

require 'should'
{Game} = require '../shared/models/game'

describe 'Game', ->
  describe '#start', ->
    context 'fewer than 2 players', ->
      it 'will not start the Game', ->
        game = new Game
        game.start.should.be.false
        
    context 'exactly 2 players', ->
      it 'marks the game as "in progress"'
      it 'sets up Pieces for each Player'

  describe '#resolveTurn', ->
    it 'color in "enclosed" squares for the enclosing Player if their opponent has no presence in the enclosed space'
    it 'evaulate win conditions after all other resolution actions'
    it 'declare a Player the "winner" if they own more than 1/2 of the Squares on the Board'
