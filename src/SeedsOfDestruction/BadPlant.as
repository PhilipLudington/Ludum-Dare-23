package SeedsOfDestruction 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import com.greensock.TweenMax;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class BadPlant extends Entity 
	{			
		[Embed(source = "/assets/BadPlant.png")] public static const BAD_PLANT:Class;
		[Embed(source = "/assets/planting.mp3")] public static const PLANTING:Class;
		public var planting:Sfx = new Sfx(PLANTING);
		
		public var spriteMap:Spritemap;
		
		public function BadPlant(x:int, y:int) 
		{
			// Make the Pink transparent
			var bitmapData:BitmapData = Global.MakeTransparent(BAD_PLANT);			
			spriteMap = new Spritemap(bitmapData, 50, 100);
			
			// Define the animations
			spriteMap.add("land", [0, 1, 2, 3], 5, false);
			spriteMap.add("grow", [4, 5, 6 ], 5, false);
			
			super(x, y, spriteMap);
			spriteMap.centerOrigin();
			
			setHitbox(5, 40);
			//centerOrigin();
			layer = 4;
			
			type = "BadPlant";
			collidable = true;
			
			planting.volume = .4;
		}
		
		override public function added():void 
		{
			super.added();
			
			spriteMap.play("land" );
			TweenMax.delayedCall(8, grow);
			
			// Increase soil nutrient useage
			(Seeds)(world).hud.badPlants += 1;
			planting.play();
		}
		public function grow():void
		{		
			spriteMap.play("grow" );
			TweenMax.delayedCall(1.5, growHitbox);
		}	
		
		public function growHitbox():void
		{
			setHitbox(9, 80);
			centerOrigin();
		}
		
		override public function update():void 
		{
		}
		
	}

}