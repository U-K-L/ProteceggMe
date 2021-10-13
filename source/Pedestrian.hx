package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class Pedestrian extends FlxSprite
{
	public var tempVelocity:Float;

	public function new(x:Float = 0, y:Float = 0, vel:Float = 0)
	{
		super(x, y);
		tempVelocity = vel;
		velocity.x = vel;
		makeGraphic(32, 32, FlxColor.BLUE);
	}
}
