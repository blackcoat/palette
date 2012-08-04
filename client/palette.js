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
