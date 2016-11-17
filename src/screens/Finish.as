package screens
{
	import events.NavigationEvent;
	
	import starling.events.Event;
	
	import utils.CustomButton;
	import engine.Map;
	
	public class Finish extends AScreen
	{
		private var button:CustomButton;
		private var buttonLabel:String;
		
		public function Finish(param:String)
		{
			super();
			buttonLabel = param;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {		
			trace ("Finish initialized");
			
			button = new CustomButton(Map.winner);
			button.x = 60;
			button.y = 200;
			this.addChild(button);
			
			addEventListener(Event.TRIGGERED, onButtonTriggered);
		}
		
		private function onButtonTriggered(event:Event):void
		{
			var b:CustomButton = event.target as CustomButton;
			
			if (b == button){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, ScreenState.START, true));
			} 	
		}
	}
}