package SeedsOfDestruction
{
	import flash.display.BitmapData;
	import Infrastructure.Room;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	public class Seed extends Entity 
	{
		[Embed(source = "/assets/Seed Small.png")] public static const SEED:Class;
		[Embed(source = "/assets/puff2.mp3")] public static const PUFF:Class;
		public var puff:Sfx = new Sfx(PUFF);
		
		public var image:Image;
		public var angleSpeed:Number = 0 ; // -2 + FP.random * 2;
		public var fallSpeed:Number = 0.6 + FP.random;
		
		public function Seed(x:int, y:int) 
		{
			// Make the Pink transparent
			var bitmapData:BitmapData = Global.MakeTransparent(SEED);
			image = new Image(bitmapData);
			
			super(x, y, image);
			image.centerOrigin();
			layer = 4;
			
			setHitbox(15, 15);
			centerOrigin();
			
			image.smooth = true;
			image.angle = 0; // FP.rand(360);
		}
		
		override public function update():void 
		{
			image.angle += angleSpeed;
			y += fallSpeed;
			
			if (collide("Explode", x, y))
			{
				Seeds(world).points ++;
				destroy();
			}
			else if (y > FP.height - 20)
			{				
				// Plant the new baby plant
				var badPlant:BadPlant = new BadPlant(x, y - 40);
				world.add(badPlant);
					
				destroy();
			}
		}
		
		public function destroy():void
		{
			puff.play();
			
			// Display the Puff clouds dispersing
			Seeds(world).puffs.emit("Puff1", x, y);
			Seeds(world).puffs.emit("Puff2", x, y);
			Seeds(world).puffs.emit("Puff3", x, y);
			Seeds(world).puffs.emit("Puff4", x, y);
			
			// Shake the camera
			Room(world).shake(10, 4);
			
			// Delete the now destroyed Invading Seed
			world.remove(this);
		}
	}
}