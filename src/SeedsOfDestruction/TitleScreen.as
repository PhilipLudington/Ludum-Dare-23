package SeedsOfDestruction
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class TitleScreen extends Entity 
	{		
		[Embed(source='/assets/TitleScreen.png')]
		private var TITLE_SCREEN:Class;
		
		public function TitleScreen() 
		{
			// Make the Pink transparent
			var bitmapData:BitmapData = Global.MakeTransparent(TITLE_SCREEN);
			var image:Image = new Image(bitmapData);
			
			super( 0, 0, image);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed
			|| Input.pressed(Key.ANY))
			{
				(Seeds)(world).Intro();
			}
		}		
	}

}