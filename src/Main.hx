package;

import lime.app.Application;

class Main extends Application
{
	var mainGame: BambaMain;
	public function new()
	{
		super();
		new BambaMain();
	}
}
