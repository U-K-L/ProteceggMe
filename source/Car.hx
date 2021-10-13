package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Car extends FlxSprite
{
	public var tempVelocity:Float;

	public function new(x:Float = 0, y:Float = 0, vel:Float = 0)
	{
		super(x, y);
		velocity.y = vel;
		tempVelocity = vel;
		makeGraphic(64, 150, FlxColor.RED);
	}
}
