import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import openfl.display.BitmapData;

class GameState extends FlxState
{
	var pedestrians:Array<Pedestrian>;
	var cars:Array<Car>;
	var pcV:Float;
	var pcV2:Float;
	var pcV3:Float;
	var safeCrossingCounter:FlxText;
	var pedestrianCount:Int;
	var stopSignTimer:Float;
	var stopSignBar:FlxBar;
	var stopSign:StopSign;

	override public function create()
	{
		super.create();
	}

	public function createMap(imageMap:BitmapData)
	{
		var width:Int = Std.int(imageMap.width);
		var height:Int = Std.int(imageMap.height);
		for (y in 0...height)
		{
			for (x in 0...width)
			{
				var pixel = imageMap.getPixel(x, y);
				trace(pixel);
				if (0xFF0000 == pixel)
				{
					var wall = new Wall(x * 32, y * 32);
					add(wall);
				}
			}
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		stopSign.updateState();

		if (pedestrianCount >= 8)
		{
			FlxG.switchState(new Stage2());
		}

		for (pedes in pedestrians)
		{
			for (car in cars)
			{
				if (FlxG.collide(pedes, car))
				{
					FlxG.switchState(new GameOver());
				}
			}
			if (pedes.x > 500 + pedes.width)
			{
				pedes.x = 0;
				pedes.tempVelocity += 50;
				pedestrianCount += 1;
			}
			pedes.velocity.x = pedes.tempVelocity;
		}
		safeCrossingCounter.text = Std.string(pedestrianCount) + "/8";

		for (car in cars)
		{
			if (car.y < 0 - car.height)
				car.y = 500;
			if (Math.abs(car.tempVelocity) > 0)
				car.tempVelocity -= 0.25;
			car.velocity.y = car.tempVelocity;
		}
		stopSignTimer -= 1;
		effectArea();
	}

	private function effectArea()
	{
		for (pedes in pedestrians)
		{
			pedes.velocity.y = 0;
			var distance = Math.sqrt(Math.pow(pedes.x - FlxG.mouse.x, 2) + Math.pow(pedes.y - FlxG.mouse.y, 2));
			if (distance < stopSign.radius * 100)
			{
				if (stopSign.signal == 0)
				{
					if (FlxG.keys.anyPressed([DOWN, S]))
						pedes.velocity.y = 300;
				}
				if (stopSign.signal == 1)
				{
					pedes.velocity.x = pedes.tempVelocity * 0.25;
				}
				else if (stopSign.signal == 2)
				{
					pedes.velocity.x = pedes.tempVelocity * 8.0;
				}
			}
		}
		// Cars
		for (car in cars)
		{
			var distance = Math.sqrt(Math.pow(car.x - FlxG.mouse.x, 2) + Math.pow(car.y - FlxG.mouse.y, 2));
			if (distance < stopSign.radius * 100)
			{
				if (stopSign.signal == 1)
				{
					car.velocity.y = car.tempVelocity * 0.25;
				}
				else if (stopSign.signal == 2)
				{
					car.velocity.y = car.tempVelocity * 3.0;
				}
			}
		}
	}
}
