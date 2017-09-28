package engine.tileStates
{
	import engine.FrameSprite;
	
	public class EmptyState implements State
	{
		
		private var stateContext:StateContext;
		
		public function EmptyState(stateContext:StateContext)
		{
			this.stateContext = stateContext;
		}
		
		public function setEmply(player:FrameSprite):void
		{
		}
		
		public function setHint(player:FrameSprite):void
		{
			player.gotoAndStop("Empty2Hint");
			stateContext.setState(stateContext.getHintState());
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