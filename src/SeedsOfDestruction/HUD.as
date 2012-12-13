package SeedsOfDestruction 
{
	import flash.display.BitmapData;
	import Infrastructure.HealthBar;
	import mx.resources.LocaleSorter;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import com.greensock.TweenMax;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Philip Ludington
	 */
	public class HUD extends Entity 
	{		
		[Embed(source='/assets/HUDImage.png')]
		private var HUDImage:Class;
		
		[Embed(source='/assets/health_bar_filler.png')]
		private var BAR_GRAPHIC:Class;
		
		[Embed(source='/assets/SeedlingBar.png')]
		private var SEEDLING_BAR:Class;
		
		private var soilBar:Image;
		private var soilBarStartY:Number = 16;
		private var seedlingBar:Image;
		public var badPlants:Number = 0;
		
		
		
		public function HUD() 
		{
			// Make the Pink transparent
			var bitmapData:BitmapData= Global.MakeTransparent(HUDImage);
			var image:Image = new Image(bitmapData);
			
			super(0, 0, image);
			
			// Make the Pink transparent
			bitmapData = Global.MakeTransparent(BAR_GRAPHIC);
			soilBar = new Image(bitmapData);			
			soilBar.x = 14;
			soilBar.y = soilBarStartY;
			addGraphic(soilBar);
			
			// Make the Pink transparent
			bitmapData = Global.MakeTransparent(SEEDLING_BAR);
			seedlingBar = new Image(bitmapData);	
			
			// Setup the Seedlings Growth bar
			seedlingBar.x = 52;
			seedlingBar.y = 16;
			addGraphic(seedlingBar);
			
			layer = 15;
		}
		
		override public function added():void 
		{
			super.added();			
		}
		override public function update():void 
		{
			super.update();
		}
		
		public function useUpSoil():void
		{
			if ( soilBar.clipRect.height == 0 )
			{
				var lose:Lose = new Lose();
				world.add(lose);
				
				return;
			}
			
			if ( seedlingBar.clipRect.height == 0 )
			{
				var win:Win = new Win();
				(Seeds)(world).Stop();
				world.add(win);
				
				return;
			}
			
			// Update the Soil Bar
			soilBar.y = FP.approach(soilBar.y, soilBar.height, Math.ceil( badPlants) + 1);
			soilBar.clipRect.height = FP.approach(soilBar.clipRect.height, 0, Math.ceil(badPlants) + 1);
            soilBar.clear();
            soilBar.updateBuffer();
			
			// Update the Seedling Bar
			seedlingBar.clipRect.height = FP.approach(seedlingBar.clipRect.height, 0, 4);
            seedlingBar.clear();
            seedlingBar.updateBuffer();
			
			TweenMax.delayedCall(1, useUpSoil);
		}
		
		public function Restart():void
		{
			// reset the soil and seedling bar
			soilBar.y = soilBarStartY;
			soilBar.clipRect.height = soilBar.height;
			seedlingBar.clipRect.height = seedlingBar.height;
			
			// reset ,the badPlant count
			badPlants = 0;
			
			TweenMax.delayedCall(1, useUpSoil);
		}
	}

}