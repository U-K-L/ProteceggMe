package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Car extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		makeGraphic(64, 200, FlxColor.RED);
	}
}
