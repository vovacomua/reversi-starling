package engine.tileStates
{
	import engine.FrameSprite;
	
	public class HintState implements State
	{
		
		private var stateContext:StateContext;
		
		public function HintState(stateContext:StateContext)
		{
			this.stateContext = stateContext;
		}
		
		public function setEmply(player:FrameSprite):void
		{
			player.gotoAndStop("Hint2Empty");
			stateContext.setState(stateContext.getEmptyState());
		}
		
		public function setHint(player:FrameSprite):void
		{
		}
		
		public function setBlack(player:FrameSprite):void
		{
			player.gotoAndStop("setB");
			stateContext.setState(stateContext.getBlackState());
		}
		
		public function setWhite(player:FrameSprite):void
		{
			player.gotoAndStop("setW");
			stateContext.setState(stateContext.getWhiteState());
		}
	}
}