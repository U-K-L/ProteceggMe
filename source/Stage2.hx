import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class Stage2 extends FlxState
{
	var pedestrian:Pedestrian;
	var pedestrian2:Pedestrian;
	var car:Car;
	var car2:Car;
	var pcV:Float;
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
		car = new Car(350, 350);
		car.velocity.y = -500;
		car2 = new Car(200, 50);
		car2.velocity.y = -500;
		safeCrossingCounter = new FlxText(550, 10, 0, "0", 32);
		add(safeCrossingCounter);
		add(car);
		add(car2);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.collide(pedestrian, car) || FlxG.collide(pedestrian, car2))
		{
			FlxG.switchState(new Stage2());
		}
		if (car.y < 0 - car.height)
			car.y = 500;
		if (car2.y < 0 - car2.height)
			car2.y = 500;
		if (pedestrian.x > 500 + pedestrian.width)
		{
			pedestrian.x = 0;
			pcV += 50;
			pedestrianCount += 1;
			safeCrossingCounter.text = Std.string(pedestrianCount);
		}
		car.velocity.y -= 0.25;
		pedestrian.velocity.x = pcV;
		stopSign();
	}

	private function stopSign()
	{
		if (FlxG.mouse.pressed)
		{
			pedestrian.velocity.x = 0;
		}
	}
}
