package SeedsOfDestruction
{
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quint;
	import com.greensock.TweenMax;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class IntroScreen extends Entity 
	{
		[Embed(source='/assets/Space.png')]
		private var SPACE:Class
		
		public var space:Image = new Image(SPACE);
		
		[Embed(source='/assets/SpaceLanding.png')]
		private var SPACE_LANDING:Class;	
		
		public var spriteMap:Spritemap
		
		public function IntroScreen() 
		{
			super(0,0, space);	
			
			// Make the Pink transparent
			var bitmapData:BitmapData = Global.MakeTransparent(SPACE_LANDING);		
			spriteMap = new Spritemap(bitmapData, 10, 100);
			addGraphic(spriteMap);
			
			// Define the animations
			spriteMap.add("launch", [0, 0, 0, 0, 0, 0, 0, 0, 0 , 0 , 0 , 0 , 0 , 0, 0 , 0 , 0,
									 0, 0, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0,0 , 0, 0 , 0 , 0,
									 0, 0, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0,0 , 
									 1, 2, 3, 4, 5, 6], 6, false);					
			spriteMap.x = 155;
			spriteMap.y = 195;
		}
		
		override public function update():void 
		{
			super.update();
			
			// Quit the story and play the game
			if (Input.mousePressed
			|| Input.pressed(Key.ANY))
			{
				(Seeds)(world).Play();
			}
		}
		
		// Play the story
		public function Start():void 
		{
			//TweenMax.to(space, 1, { y: -389, ease:Linear.easeIn, onComplete:HoldThenFinish } );
			TweenMax.to(space, 8, { y: -389, ease:Linear.easeIn, onComplete:HoldThenFinish } );
			spriteMap.play("launch");
		}
		//public function PanIn(): void
		//{
			//TweenMax.to(space, 1, { x: -100, y: -489, ease:Linear.easeIn, onComplete:Launch } );
		//}  
		//public function Launch():void 
		//{
			//spriteMap.x = 159;
			//spriteMap.y = 78;
			//addGraphic(spriteMap);
			//spriteMap.play("launch" );
			//
			//TweenMax.delayedCall(7, Finish);
		//}
		//
		//public function Travel():void 
		//{		
			//addGraphic(spriteMap);
			//spriteMap.play("launch" );
		//}
		public function Finish():void 
		{
			if ( world )
			{
				(Seeds)(world).Play();
			}
		}
		
		public function HoldThenFinish():void
		{
			TweenMax.delayedCall(1.2, Finish);
		}
	}

}