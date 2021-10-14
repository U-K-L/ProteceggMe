import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxBar;

class Stage1 extends GameState
{
	override public function create()
	{
		super.create();
		pedestrianCount = 0;
		var pedestrian = new Pedestrian(-20, 150, 98);
		add(pedestrian);

		var pedestrian2 = new Pedestrian(50, 250, 78);
		add(pedestrian2);

		var pedestrian3 = new Pedestrian(70, 50, 48);
		add(pedestrian3);

		pedestrians = [pedestrian, pedestrian2, pedestrian3];

		var car = new Car(350, 250, -300);
		add(car);
		var car2 = new Car(350, 50, 0);
		add(car2);
		var car3 = new Car(350, 350, 0);
		add(car3);

		cars = [car, car2, car3];

		safeCrossingCounter = new FlxText(550, 10, 0, "0/8", 32);
		add(safeCrossingCounter);
		stopSignTimer = 100;
		stopSignBar = new FlxBar(500, 32, LEFT_TO_RIGHT, 100, 10, null, "stopSignTimer", 0, 100, true);
		// add(stopSignBar);

		stopSign = new StopSign(250, 250);
		add(stopSign);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
