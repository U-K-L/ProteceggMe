import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;

class GameState extends FlxState
{
	var pedestrians:Array<Pedestrian>;
	var pedestrian:Pedestrian;
	var pedestrian2:Pedestrian;
	var pedestrian3:Pedestrian;
	var car:Car;
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
		pedestrianCount = 0;
		pedestrian = new Pedestrian(-20, 150, 158);
		add(pedestrian);

		pedestrian2 = new Pedestrian(50, 250, 178);
		add(pedestrian2);

		pedestrian3 = new Pedestrian(70, 50, 148);
		add(pedestrian3);

		pedestrians = [pedestrian, pedestrian2, pedestrian3];

		car = new Car(350, 250, -300);
		safeCrossingCounter = new FlxText(550, 10, 0, "0/8", 32);
		add(safeCrossingCounter);
		add(car);

		stopSignTimer = 100;
		stopSignBar = new FlxBar(500, 32, LEFT_TO_RIGHT, 100, 10, null, "stopSignTimer", 0, 100, true);
		// add(stopSignBar);

		stopSign = new StopSign(250, 250);
		add(stopSign);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		stopSign.updateState();
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

		for (pedes in pedestrians)
		{
			if (FlxG.collide(pedes, car))
			{
				FlxG.switchState(new GameOver());
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
		car.tempVelocity -= 0.25;
		car.velocity.y = car.tempVelocity;

		stopSignTimer -= 1;
		effectArea();
	}

	private function effectArea()
	{
		for (pedes in pedestrians)
		{
			var distance = Math.sqrt(Math.pow(pedes.x - FlxG.mouse.x, 2) + Math.pow(pedes.y - FlxG.mouse.y, 2));
			if (distance < stopSign.radius * 100)
			{
				if (stopSign.signal == 1)
				{
					pedes.velocity.x = pedes.tempVelocity * 0.1;
				}
				else if (stopSign.signal == 2)
				{
					pedes.velocity.x = pedes.tempVelocity * 3.0;
				}
			}
		}

		// Cars
		var distance = Math.sqrt(Math.pow(car.x - FlxG.mouse.x, 2) + Math.pow(car.y - FlxG.mouse.y, 2));
		if (distance < stopSign.radius * 100)
			if (stopSign.signal == 1)
			{
				car.velocity.y = car.tempVelocity * 0.1;
			}
			else if (stopSign.signal == 2)
			{
				car.velocity.y = car.tempVelocity * 3.0;
			}
	}
}
