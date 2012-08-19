##
# Spec-style unit tests for Pieces moved by Players in Palette

require 'should'
require '../shared/models/game'

describe 'Game', ->
  describe '#resolveTurn', ->
    it 'color in "enclosed" squares for the enclosing Player if their opponent has no presence in the enclosed space'
    it 'evaulate win conditions after all other resolution actions'
    it 'declare a Player the "winner" if they own more than 1/2 of the Squares on the Board'
