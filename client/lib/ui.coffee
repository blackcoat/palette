##
# User Interface Behaviors
# 
# Gameplay animations and UI behaviors belong to more than
# just one template. For now, we're going to namespace all
# such items in the UI object
UI = 
  clear_selection: ->
    $('.selected').removeClass('selected')
    $('#board-overlay').fadeOut('fast')
    $('.square').removeClass('destination')
    Session.set 'selected_square', null
  
  select: (square) ->
    Session.set 'selected_square', JSON.stringify square
    $('#' + square._id).addClass('selected')
  
  show_destinations: (origin) ->
    # Keep a list of which directions we go in away from the origin
    # Each direction has a vector that we will scale to track
    # how far away we go from the origin of our move.
    if origin.occupant.type is 'rook'
      directions = 
        n: {row:-1, col: 0}
        s: {row: 1, col: 0}
        e: {row: 0, col: 1}
        w: {row: 0, col:-1}
    else 
      directions = 
        nw: {row:-1, col:-1}
        ne: {row:-1, col: 1}
        se: {row: 1, col: 1}
        sw: {row: 1, col:-1}
    
    # Search for how far we can move a piece in each direction.
    # Stop searching for destinations in a direction if...
    # * a Square is occupied by another Piece
    # * we encounter a Square of the opposite color
    # * we would be moving beyond the boundaries of the board
    
    player_colors = ['white', 'black']
    
    selectors = []
    for direction,vector of directions
      offset = 0
      square = origin
      while square? and (square is origin or not square.occupant?) and ($.xcolor.nearestname(square.color) not in player_colors or $.xcolor.nearestname(square.color) is origin.occupant.owner)
        selectors.push '.square[data-row=' + (origin.row + offset * vector.row) + '][data-col=' + (origin.col + offset * vector.col) + ']'
        offset += 1
        square = Squares.findOne {row: (origin.row + offset * vector.row), col: (origin.col + offset * vector.col), game_id: origin.game_id}
    destinations = $(selectors.join ',')
    destinations.not('.selected').addClass('destination')
    $('#board-overlay').fadeIn('fast')
  
  update_colors: (origin, destination) ->
    piece = origin.occupant
    # If you are playing white or black, you can't use your desired
    # end color as a new painting_color. Otherwise, the game would
    # be far too easy. "I'll add white to *everything*"
    player_colors = ['white', 'black']
    painting_color = origin.color unless $.xcolor.nearestname(origin.color) in player_colors
    
    # Determine how our colors will be combined.
    mode = if piece.owner is 'white' then 'additive' else 'subtractive'
    
    for r in [origin.row..destination.row]
      for c in [origin.col..destination.col] when r isnt origin.row or c isnt origin.col # don't paint our origin
        if piece.type is 'rook' or (piece.type is 'bishop' and Math.abs(origin.row - r) is Math.abs(origin.col - c))
          square = Squares.findOne {row: r, col: c, game_id: origin.game_id}
          if painting_color? and $.xcolor.nearestname(square.color) not in player_colors
            square.color = $.xcolor[mode](square.color, painting_color).toString()
            Squares.update square._id, {$set: {color: square.color}}
          else
            # Pick up a new painting color if we don't have one already,
            # but we can't use our desired outcome color (white/black) as
            # a painting color
            painting_color = square.color unless $.xcolor.nearestname(square.color) in player_colors