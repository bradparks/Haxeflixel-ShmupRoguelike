package objects.items;
import flixel.addons.effects.FlxTrail;
import flixel.math.FlxPoint;
import objects.Player;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;
import flixel.FlxObject;

class CoinItem extends Item
{
	public var magnetized:Bool;
	private var bTrail:FlxTrail;
	private var rotspeed:Int = 5;

	public function new(x:Float,y:Float) 
	{
		super(x, y);
		var t = FlxG.random.int(2, 5);
		makeGraphic(t,t, FlxColor.WHITE);
		offset.set( -4, -4);
		centerOffsets();
		lifespan = 4;

        bTrail = new FlxTrail(this, null, 10, 1, 0.5, 0.05);
		Reg.PS.effects.add(bTrail);
	}
		
	override public function update(elapsed:Float)
	{
	 magnetize();
	 angle += rotspeed;

		if (magnetized)
		move();
		else
		{
		   velocity.set(0, 0);
		   acceleration.set(0, 0);
		}
		
	    noOverlapping();
		
		super.update(elapsed);
	}
	
	private function magnetize()
	{
		if (FlxMath.absInt(FlxMath.distanceBetween(this,Reg.PS.player)) < Reg.PS.player.MAGNET )
			magnetized = true;	
	}

	private function move()
	{
		FlxVelocity.accelerateTowardsObject(this, Reg.PS.player, Reg.PS.player.MAGNET * 100, Reg.PS.player.MAGNET_FORCE * 200);

	}
	
	private function noOverlapping()
	{
		for (coin in Reg.PS.coins)
		{
			if (FlxG.overlap(this, coin))
			{
				FlxObject.separate(this, coin);
			}
		}
	}
	
	override public function kill()
	{
		lifespan = 4;
		Reg.PS.coins.remove(this, true);
		Reg.PS.effects.remove(bTrail, true);
		super.kill();
	}
	
    override function interact(player:Player)
	{
	  kill();
	  Reg.score += 5;
	}
	
}