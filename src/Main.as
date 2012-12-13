package 
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.geom.Rectangle;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import SeedsOfDestruction.Seeds;
	import Infrastructure.MouseCursor;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class Main extends Engine 
	{
		public function Main()
		{
			super(400, 300, 60);
			
			FP.screen.scale = 2;
			FP.screen.color = 0xFFFFFF;
			Input.mouseCursor = MouseCursor.HIDE.ToString();
			
			// Which game to play:
			var theWorld:Seeds = new Seeds();
			
			// Game On!
			FP.world = theWorld;			
		}
	}
	
}
