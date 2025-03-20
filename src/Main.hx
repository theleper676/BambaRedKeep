package;

import lime.app.Application;

class Main extends Application
{
	var mainGame: BambaMovie;
	public function new()
	{
		super();
		mainGame = new BambaMovie(1);
	}
}
