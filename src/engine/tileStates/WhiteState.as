package engine.tileStates
{
	import engine.FrameSprite;
	
	public class WhiteState implements State
	{
		
		private var stateContext:StateContext;
		
		public function WhiteState(stateContext:StateContext)
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
			player.gotoAndStop("flip2B");
			stateContext.setState(stateContext.getBlackState());
		}
		
		public function setWhite(player:FrameSprite):void
		{
		}
	}
}