package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
	var playButton:FlxButton;

	override public function create()
	{
		super.create();
		playButton = new FlxButton(0, 0, "Play", clickPlay);
		add(playButton);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function clickPlay()
	{
		FlxG.switchState(new GameState());
	}
}
