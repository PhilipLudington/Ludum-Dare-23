package Infrastructure 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class HealthBar extends Entity
	{
		public var minimum:Number = 0;
		public var maximum:Number = 100;
		public var value:Number = maximum;
		
		private var img:Image;
		private var clippingRectangle:Rectangle = new Rectangle(0, 0, 0, 0);
		private var imgWidth:Number;
		
		[Embed(source='/assets/health_bar_filler.png')]
		private var BAR_GRAPHIC:Class;
		
		public function HealthBar(minimumValue:Number = 0, maximumValue:Number = 100, initialValue:Number = 100):void
		{
			minimum = minimumValue;
			maximum = maximumValue;
			value = initialValue;
			img = new Image(BAR_GRAPHIC, clippingRectangle);
			clippingRectangle.width = img.width;
			clippingRectangle.height = img.height;
			clippingRectangle.x = 0;
			clippingRectangle.y = 0;
			graphic = img;
			imgWidth = img.width;
			UpdateBarWidth();
		}
		
		private function UpdateBarWidth():void
		{
			// make sure the bar is drawn correctly
			var newWidth:Number = (imgWidth * (value / 100.0));
			
			// cannot draw 0 pixels
			if (newWidth <= 0)
			{
				newWidth = 1;
			}
			clippingRectangle.width = newWidth;
			img.clear();
			img.updateBuffer();
			graphic = img;
		}
		
		// "damages" the health bar
		public function Damage(amount:Number = 1):void
		{
			value = value - amount;
			if (value < minimum)
			{
				value = minimum;
			}
			UpdateBarWidth();
		}
		
		// "heals" the health bar
		public function Heal(amount:Number = 1):void
		{
			value = value + amount;
			if (value > maximum)
			{
				value = maximum;
			}
			UpdateBarWidth();
		}
	}
}