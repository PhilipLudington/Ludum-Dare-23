package SeedsOfDestruction
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	
	public class Player extends Entity 
	{
		[Embed(source = "/assets/body.png")] public static const BODY:Class;
		[Embed(source = "/assets/stem.png")] public static const STEM:Class;
		[Embed(source = "/assets/shot.mp3")] public static const SHOT:Class;
		
		public static const SHOT_TIMER:int = 30;
		
		public var shot:Sfx = new Sfx(SHOT);
		
		public var body:Image;
		public var stem:Image;;
		public var shotTimer:int = 0;		
		
		public function Player(x:int, y:int) 
		{
			// Make the Pink transparent
			var bitmapData:BitmapData = Global.MakeTransparent(BODY);
			body = new Image(bitmapData);
			
			bitmapData = Global.MakeTransparent(STEM);
			stem = new Image(bitmapData);
			
			body.originX = body.width / 2;
			body.originY = body.height;
			stem.originX = -10;
			stem.originY = stem.height / 2;
			
			super(x, y, new Graphiclist(stem, body));
			stem.angle = 90;
			stem.smooth = true;
			layer = 1;
		}
		
		override public function update():void 
		{
			stem.angle = FP.angle(x, y, world.mouseX, world.mouseY);
			
			if (shotTimer > 0)
			{
				shotTimer--;
				stem.visible = !stem.visible;
			}
			else
			{
				stem.visible = true;
				
				if (Input.mousePressed
				&& active)
				{
					world.add(new SeedBullet(this));
					shotTimer = 30;
					shot.play();
				}
			}
		}
	}
}