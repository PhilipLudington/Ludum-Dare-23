package SeedsOfDestruction
{
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import flash.display.BitmapData;
	import flash.ui.MouseCursor;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.motion.Motion;
	import net.flashpunk.utils.Ease;
	
	public class SeedBullet extends Entity 
	{
		[Embed(source = "/assets/Seed Bullet.png")] public static const SEED_BULLET:Class;
		
		public static const SPEED:Number = 200;
		
		public var image:Image;
		
		public function SeedBullet(player:Player) 
		{
			// Make the Pink transparent
			var bitmapData:BitmapData = Global.MakeTransparent(SEED_BULLET);
			image = new Image(bitmapData);
			
			image.centerOrigin();
			
			FP.angleXY(this, player.stem.angle,9, player.x, player.y);
			graphic = image;
			image.smooth = true;
			layer = 2;
			
			// Collision Box
			setHitbox(9, 9);
			type = "seedbullet";
			centerOrigin();		
		}
		
		override public function update():void 
		{			
			super.update();
			
			if (collide("BadPlant", x, y))
			{
				explode();
			}
		}
		
		override public function added():void 
		{
			super.added();
			
			var time:Number = FP.distance(x, y, world.mouseX, world.mouseY) / SPEED;
			//var tween:LinearMotion = new LinearMotion(explode, Tween.ONESHOT);
			//tween.setMotion( x, y, world.mouseX, world.mouseY, time, Ease.quadOut );
			//addTween(tween);
			//tween.start();
			TweenMax.to(this, time, { x:world.mouseX, y:world.mouseY, ease:Quad.easeOut, onComplete:explode } );
		}
		
		public function explode():void
		{
			if ( world == null )
			{
				// I am already dead, do nothing
			}
			else
			{			
				world.add(new Explode(this));
				world.remove(this);
			}
		}
	}
}