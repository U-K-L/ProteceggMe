package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class GameOver extends FlxState
{
	var playButton:FlxButton;

	override public function create()
	{
		super.create();
		var gameOver = new FlxText(150, 75, 0, "GAME OVER", 48);
		add(gameOver);
		playButton = new FlxButton(0, 0, "Try Again?", clickPlay);
		playButton.screenCenter();
		add(playButton);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function clickPlay()
	{
		FlxG.switchState(new Stage1());
	}
}
