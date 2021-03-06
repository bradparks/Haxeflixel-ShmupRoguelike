package utils.controls;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import openfl.system.System;
import utils.pcg.MapChunkMerger;

class Gamepad
{
public static var GAMEPAD:FlxGamepad;

// This needs to be re-implemented properly!!!

	public static function checkForGamepad()
	{
		GAMEPAD = FlxG.gamepads.lastActive;
	}
	
	public static function updateGameInputs()
	{

		if (GAMEPAD != null)
		{
			
		if (GAMEPAD.justPressed.START)
		{
			Reg.pause = !Reg.pause;
		}
		
		if (GAMEPAD.pressed.A || GAMEPAD.pressed.RIGHT_SHOULDER ||
		    GAMEPAD.pressed.RIGHT_TRIGGER)
		{
		 Reg.PS.player.shoot();
		}
		
		if (GAMEPAD.pressed.DPAD_UP)
		{
			Reg.PS.player.move_up();
		}
		
		if (GAMEPAD.pressed.DPAD_RIGHT)
		{
			Reg.PS.player.move_right();
		}
		
				
		if (GAMEPAD.pressed.DPAD_LEFT)
		{
			Reg.PS.player.move_left();
		}
		
		if (GAMEPAD.pressed.DPAD_DOWN)
		{
			Reg.PS.player.move_down();
		}

		
		if(GAMEPAD.justPressed.GUIDE)
		{
			System.exit(0);
		}// obvious debug
		
		if (GAMEPAD.pressed.BACK)
		{
			FlxG.resetState();
		}
			
		if (GAMEPAD.justReleased.ANY)
		{
			Reg.PS.player.resetAccel();
		}
		}
		
		
		if (FlxG.keys.anyJustPressed(Keyboard.pauseKeys))
		{
			Reg.pause = !Reg.pause;
		}
		
		if (FlxG.keys.anyPressed(Keyboard.actionKeys))
		{
		 Reg.PS.player.shoot();
		}
		
		if (FlxG.keys.anyPressed(Keyboard.upKeys))
		{
			Reg.PS.player.move_up();
		}
		
		if ( FlxG.keys.anyPressed(Keyboard.rightKeys))
		{
			Reg.PS.player.move_right();
		}
		
				
		if ( FlxG.keys.anyPressed(Keyboard.leftKeys))
		{
			Reg.PS.player.move_left();
		}
		
		if ( FlxG.keys.anyPressed(Keyboard.downKeys))
		{
			Reg.PS.player.move_down();
		}

		
		if( FlxG.keys.justPressed.ESCAPE)
		{
			System.exit(0);
		}// obvious debug
		
		if ( FlxG.keys.justPressed.R)
		{
			FlxG.resetState();
		}
			
		if ( FlxG.keys.justReleased.ANY)
		{
			Reg.PS.player.resetAccel();
		}
		
	}
		
	
}
