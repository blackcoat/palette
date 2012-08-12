Template.hello.greeting = function () {
	return "Welcome to palette, a two-player color-matching game.";
};

Template.hello.events = {
	'click input' : function () {
		// template data, if any, is available in 'this'
		if (typeof console !== 'undefined')
		console.log("You pressed the button");
	}
};

Template.board.squares = function () {
	var board = new Board;
	return jQuery.map( board.squares, function(n) {
	  return n
	})
}