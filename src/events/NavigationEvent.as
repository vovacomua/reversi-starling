package events
{
	import starling.events.Event;
	
	public class NavigationEvent extends Event
	{
		public static const CHANGE_SCREEN:String = "changeScreen";
		
		public var screen:String;
		public var scoreResult:String;
		
		public function NavigationEvent(type:String, _screen:String, bubbles:Boolean = false, _scoreResult:String = null)
		{
			super(type, bubbles);
			
			this.screen = _screen;
			if (_scoreResult != null){
				this.scoreResult = _scoreResult;	
			}
		}
	}
}