package SeedsOfDestruction
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class Lose extends Entity 
	{		
		[Embed(source='/assets/LoseScreen.png')]
		private var LOSE_SCREEN:Class;
		
		public function Lose() 
		{
			// Make the Pink transparent
			var bitmapData:BitmapData = Global.MakeTransparent(LOSE_SCREEN);
			var image:Image = new Image(bitmapData);
			
			super( 0, 0, image);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed
			|| Input.pressed(Key.ANY))
			{
				var a:Seeds = (Seeds)(FP.world);
				a.Stop();
				FP.world = new Seeds();
			}
		}
	}

}