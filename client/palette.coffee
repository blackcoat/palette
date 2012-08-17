Template.hello.greeting = ->
  "Welcome to palette, a two-player color-matching game."

Template.board.squares = ->
  board = new Board
  jQuery.map board.squares, (n) -> n

Template.square.events = 'click' : ->
  console.log("You clicked on:")
  console.log(this)