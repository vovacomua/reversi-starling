package 
{
	import events.NavigationEvent;
	
	import flash.display.Bitmap;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import screens.*;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import utils.CustomButton;
	
	public class ScreenManager extends Sprite
	{
		Start; Game; Finish;
		
		private var currentScreen:AScreen;
		
		public function ScreenManager()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void 
		{		
			trace ("starling initialized");

			this.addEventListener(events.NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			showScreen(ScreenState.START);
		}
		
		private function showScreen(screen:String, message:String = null):void
		{
			//a bit overly sophisticated way of initializing just to practise the approach 
			if (currentScreen != null){
				currentScreen.removeFromParent(true);
			}
			
			var sceneClass:Class = getDefinitionByName("screens."+screen) as Class;
			currentScreen = new sceneClass(message) as AScreen;	
		
			this.addChild(currentScreen);
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			trace(event.screen);
			showScreen(event.screen, event.scoreResult);
		}
	}
}