package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class StopSign extends FlxSprite
{
	public var tempVelocity:Float;
	public var circle:FlxSprite;
	public var signal:Int; // 0 == green GO, 1 == Red STOP, 2 == Yellow SPEED UP
	public var stopColor:Int;
	public var goColor:Int;
	public var speedColor:Int;
	public var radius:Float;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		stopColor = 0x6FFF3684;
		goColor = 0x3FC7FFC3;
		speedColor = 0x6FEBD65A;
		makeGraphic(500, 500, FlxColor.TRANSPARENT);
		signal = 0;
		// 0x6FFF3684
		radius = 1.0;
		circle = this.drawCircle(-1, -1, 100, goColor);
	}

	public function updateState()
	{
		updatePosition();
		updateColor();
		updateScale();
	}

	function updatePosition()
	{
		this.x = FlxG.mouse.x - 500 / 2;
		this.y = FlxG.mouse.y - 500 / 2;
	}

	function updateColor()
	{
		if (FlxG.mouse.pressed)
		{
			signal = 1;
		}
		else if (FlxG.mouse.pressedRight)
		{
			signal = 2;
		}
		else
		{
			signal = 0;
		}

		if (signal == 1)
			circle.color = stopColor;
		else if (signal == 2)
			circle.color = speedColor;
		else
			circle.color = goColor;
	}

	function updateScale()
	{
		if (FlxG.mouse.wheel != 0)
		{
			radius += FlxG.mouse.wheel / 10;
			radius = Math.max(radius, 0.25);
			radius = Math.min(radius, 1.5);
			circle.scale.set(radius, radius);
		}
	}
}
