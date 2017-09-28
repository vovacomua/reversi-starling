package engine.tileStates
{
	import engine.FrameSprite;
	
	public class BlackState implements State
	{
		
		private var stateContext:StateContext;
		
		public function BlackState(stateContext:StateContext)
		{
			this.stateContext = stateContext;
		}
		
		public function setEmply(player:FrameSprite):void
		{
		}
		
		public function setHint(player:FrameSprite):void
		{
		}
		
		public function setBlack(player:FrameSprite):void
		{
		}
		
		public function setWhite(player:FrameSprite):void
		{
			player.gotoAndStop("flip2W");
			stateContext.setState(stateContext.getWhiteState());
		}
	}
}