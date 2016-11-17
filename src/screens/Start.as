package screens
{
	import events.NavigationEvent;
	
	import starling.events.Event;
	
	import utils.CustomButton;
	
	public class Start extends AScreen
	{
		private var button:CustomButton;
		
		public function Start(param:String = null)
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {		
			trace ("START initialized");
			
			button = new CustomButton('=START=');
			button.x = 60;
			button.y = 200;
			this.addChild(button);
			
			addEventListener(Event.TRIGGERED, onButtonTriggered);
		}
		
		private function onButtonTriggered(event:Event):void
		{
			var b:CustomButton = event.target as CustomButton;
			
			if (b == button){	
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, ScreenState.GAME, true));
			} 	
		}
	}
}