package objects.enemies;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import objects.enemies.EnemyBullet;
import flixel.math.FlxPoint;
import objects.enemies.Enemy;
import objects.items.CoinItem;
import objects.items.HealthItem;
import objects.items.HealthMaxItem;
import objects.items.Item;
import objects.Player;
import objects.items.SpeedItem;

class EnemyTurretA extends Enemy
{

    private static inline var SCORE_AMOUNT:Int = 100;
	private static inline var SHOOT_SPEED = 200;
	
	private var bullet:EnemyBullet;
	private var justShot:Bool;
	private var shootDelay:Float = 2;
	

	
	private  var ceiling:Bool;
	
	
	
	public function new(x:Float, y:Float, flip:Bool) 
	{
		super(x, y-4); // this causes an issue if turret is on ceiling... needs to use ceiling instance variable.
		HP = 1;
	    ceiling = (flip ? true : false);
		loadGraphic(AssetPaths.turret__png, true, 8, 8);
		animation.add("idle", [0]);
		animation.add("shoot", [1]);
		animation.play("idle");
		immovable = true;
		solid = true;
		flipY = flip;
	}
	
	override public function update(elapsed:Float)
	{
		if (!justShot)
			shoot();
		else
		   animation.play("idle");
		super.update(elapsed);
	}
	
	override public function kill():Void
	{
		var drops:Array<Item> = [new HealthItem(x,y), new SpeedItem(x,y), new HealthMaxItem(x,y)];
		dropItem(drops);
		super.kill();
	
	}
	private function shoot():Void
	{
		// the bullet speed should be a variable that is passed at creation, depending on the flipped value of the enemyTurret
		justShot = true;
		var eb:EnemyBullet = Reg.PS.EBullets.recycle();
	    if (eb == null)
		    eb = new EnemyBullet(x, y);
		
		if (!ceiling)
		{
		eb.reset(x + 3, y - 4 );
		eb.velocity.y = -SHOOT_SPEED;
		}
		else
		{
		eb.reset(x + 2, y - 4 );
		eb.velocity.y = SHOOT_SPEED;			
		}
	     Reg.PS.EBullets.add(eb);

		new FlxTimer().start(shootDelay, function(_)
		{
			justShot = false;
			animation.play("shoot");
		}, 1);
		
	}
	

}