package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class Wall extends FlxSprite
{
	public var tempVelocity:Float;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		makeGraphic(32, 32, FlxColor.WHITE);
	}
}
