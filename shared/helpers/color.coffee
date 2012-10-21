class Color
  @threshold = 3
  
  # If a color is very close to black or white, round it!
  @correct = (color) ->
    colorsToCheck = ['#ffffff', '#000000']
    for baseColor in colorsToCheck
      if $.xcolor.distance(color, baseColor) <= @threshold
        return baseColor
    color


# Export our class to Node.js when running
# other modules, e.g. our Mocha tests
exports.Color = Color unless Meteor?