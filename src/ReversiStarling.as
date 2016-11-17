package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;

	
	[SWF(framerate="10", width="420", height="585", backgroundColor="0x999999")]
	
	public class ReversiStarling extends Sprite
	{
		private var myStarling:Starling;
		
		public function ReversiStarling()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			myStarling = new Starling(ScreenManager, stage );
			
			myStarling.antiAliasing = 0;
			myStarling.start();
		}
		
	}
}