import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class GameState extends FlxState
{
	var pedestrian:Pedestrian;
	var pedestrian2:Pedestrian;
	var pedestrian3:Pedestrian;
	var car:Car;
	var pcV:Float;
	var pcV2:Float;
	var pcV3:Float;
	var safeCrossingCounter:FlxText;
	var pedestrianCount:Int;

	override public function create()
	{
		super.create();
		pedestrianCount = 0;
		pedestrian = new Pedestrian(-20, 150);
		pedestrian.velocity.x = 158;
		pcV = pedestrian.velocity.x;
		add(pedestrian);

		pedestrian2 = new Pedestrian(50, 350);
		pedestrian2.velocity.x = 178;
		pcV2 = pedestrian2.velocity.x;
		add(pedestrian2);

		pedestrian3 = new Pedestrian(70, 50);
		pedestrian3.velocity.x = 148;
		pcV3 = pedestrian3.velocity.x;
		add(pedestrian3);

		car = new Car(350, 350);
		car.velocity.y = -500;
		safeCrossingCounter = new FlxText(550, 10, 0, "0/8", 32);
		add(safeCrossingCounter);
		add(car);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.collide(pedestrian, car) || FlxG.collide(pedestrian2, car) || FlxG.collide(pedestrian3, car))
		{
			FlxG.switchState(new GameOver());
		}
		if (pedestrianCount >= 8)
		{
			FlxG.switchState(new Stage2());
		}
		if (car.y < 0 - car.height)
			car.y = 500;
		if (pedestrian.x > 500 + pedestrian.width)
		{
			pedestrian.x = 0;
			pcV += 50;
			pedestrianCount += 1;
		}

		if (pedestrian2.x > 500 + pedestrian2.width)
		{
			pedestrian2.x = 0;
			pcV2 += 50;
			pedestrianCount += 1;
		}

		if (pedestrian3.x > 500 + pedestrian3.width)
		{
			pedestrian3.x = 0;
			pcV3 += 50;
			pedestrianCount += 1;
		}
		safeCrossingCounter.text = Std.string(pedestrianCount) + "/8";
		car.velocity.y -= 0.25;
		pedestrian.velocity.x = pcV;
		pedestrian2.velocity.x = pcV2;
		pedestrian3.velocity.x = pcV3;
		stopSign();
	}

	private function stopSign()
	{
		if (FlxG.mouse.pressed)
		{
			if (FlxG.mouse.overlaps(pedestrian))
				pedestrian.velocity.x = 0;
			if (FlxG.mouse.overlaps(pedestrian2))
				pedestrian2.velocity.x = 0;
			if (FlxG.mouse.overlaps(pedestrian3))
				pedestrian3.velocity.x = 0;
		}
		if (FlxG.keys.pressed.SPACE)
		{
			pedestrian.velocity.x = 0;
			pedestrian2.velocity.x = 0;
			pedestrian3.velocity.x = 0;
		}
	}
}
